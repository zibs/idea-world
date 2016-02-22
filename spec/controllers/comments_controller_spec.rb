require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:idea){create(:idea)}
  let(:user){create(:user)}
  let(:comment){create(:comment, {idea: idea, user: user})}
  let(:other_comment){create(:comment) }

describe "#create" do
  context "authenticated user" do
    before { log_in(user) }
    context "with valid params" do
      let!(:idea){create(:idea)}
      def valid_post_request
        post :create, idea_id: idea.id, comment: attributes_for(:comment)
      end
      it "creates a record in the db" do
      expect{valid_post_request}.to change{idea.comments.count}.by(1)
      end

      it "associates the pledge with the logged in user" do
        valid_post_request
        expect(idea.comments.last.user).to eq(user)
      end

      it "redirects to the campaign show page" do
        expect(valid_post_request).to redirect_to(idea_path(idea))
      end

      it "sets a flash notice" do
        valid_post_request
        expect(flash[:success]).to be
      end
    end

    context "with invalid params" do
      let!(:idea){create(:idea)}

      def invalid_post_request
        post :create, idea_id: idea.id, comment: attributes_for(:comment, {body: nil})
      end
      it "doesn't creates a record in the db" do
      expect{invalid_post_request}.to change{idea.comments.count}.by(0)
      end

      it "redirects to the campaign show page" do
        expect(invalid_post_request).to render_template("ideas/show")
      end

      it "sets a flash notice" do
        invalid_post_request
        expect(flash[:warning]).to be
      end
    end
  end

  context "unauthenticated user" do
    let!(:idea){create(:idea)}
    it "redirects to the sign in page" do
      post :create, idea_id: idea.id, comment: attributes_for(:comment)
      expect(response).to redirect_to(new_session_path)
    end
  end

end

describe "#destroy" do
    context "authenticated user" do
    let!(:comment){create(:comment, {idea: idea, user: user})}

      context "authorized user" do
        before { log_in(user) }
        def destroy_comment
          delete :destroy, id: comment, idea_id: idea
        end

        it "removes the comment from the database" do
          expect{destroy_comment}.to change{Comment.count}.by(-1)
        end

        it "redirects to the idea show page" do
          destroy_comment
          expect(response).to redirect_to(idea_path(idea))
        end

        it "sets a flash message" do
          destroy_comment
          expect(flash[:danger]).to be
        end


      context "unauthorized user" do
        let!(:other_comment){create(:comment) }

        it "raises an error" do
          expect do
            delete :destroy, id: other_comment.id, idea_id: other_comment.idea_id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

    context "unauthenticated user" do
      let!(:comment){create(:comment, {idea: idea, user: user})}
      it "redirects to the sign in page" do
        post :create, idea_id: idea.id, comment: comment
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
