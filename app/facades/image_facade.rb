class ImageFacade
  def image_of(descriptor)
    data = service.get_image_data(descriptor)

    @gif = Giphy.new(data)
  end

  private

  def service
    ImageService.new
  end
end
