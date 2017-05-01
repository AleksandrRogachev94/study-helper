class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :avatar_url, :properties

  def avatar_url
    ActionController::Base.helpers.asset_path(object.avatar.url(:original))
  end

  def properties
    {
      phone_number: object.phone_number,
      age: object.age,
      study_place: object.study_place,
      degree: object.degree,
      interests: object.interests,
      created_at: object.created_at.to_s
    }
  end
end
