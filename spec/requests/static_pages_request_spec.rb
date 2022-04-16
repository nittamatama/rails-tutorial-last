require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "titleにHome | Ruby on Rails Tutorial Sample Appが表示される" do
      get root_path
      expect(response.body).to include "Home | #{base_title}"
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get static_pages_help_path
      expect(response).to have_http_status(:success)
    end

    it "titleにHelp | Ruby on Rails Tutorial Sample Appが表示される" do
      get static_pages_help_path
      expect(response.body).to include "Help | #{base_title}"
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get static_pages_about_path
      expect(response).to have_http_status(:success)
    end

    it "titleにAbout | Ruby on Rails Tutorial Sample Appが表示される" do
      get static_pages_about_path
      expect(response.body).to include "About | #{base_title}"
    end
  end

end
