class UserController < ApplicationController
  before_filter :disable_nav, only: [:register]

  def index

  end
end
