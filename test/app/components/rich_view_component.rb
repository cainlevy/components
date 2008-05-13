class RichViewComponent < Components::Base
  def urler
    render
  end

  def linker(url)
    @url = url
    render
  end
end