class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def return_error(resource)
    if !!resource.try(:errors)
      serialize_error(resource.errors.full_messages.uniq.to_sentence)
    else
      e
    end
  end

  def serialize_error(errors)
    { error: errors }
  end

  def params_hash(object)
    object.to_h.with_indifferent_access
  end

  def current_user
    return unless doorkeeper_token
    user = User.find(doorkeeper_token.resource_owner_id)
    user
  end
end
