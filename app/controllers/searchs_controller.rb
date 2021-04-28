class SearchsController < ApplicationController
   before_action :authenticate_user!
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @model, @value)
  end

  private
  def match(model, value)
    if model == 'user'
      User.where(users_name: value)
    elsif model == 'post'
      Post.where(body: value)
    end
  end

  def partical(model, value)
    if model == 'user'
      User.where("users_name LIKE ?", "%#{value}%")
    elsif model == 'post'
      Post.where("body LIKE ?", "%#{value}%")
    end
  end

  def search_for(how, model, value)
    case how
    when 'match'
      match(model, value)
    when 'partical'
      partical(model, value)
    end
  end
end