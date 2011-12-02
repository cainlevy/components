class Components::View < ActionView::Base
  delegate :protect_against_forgery?, :form_authenticity_token, :to => :controller
end