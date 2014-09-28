Butler::App.controllers :door do
  post :ring do
    Door.ring
    {success: true}.to_json
  end
end
