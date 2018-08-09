module Request
  module ResourceBasedMethods

    def get_user(user_id, params = nil, headers = nil)
      get("/api/v1/users/#{user_id}", params, headers)
    end

  end
end
