class HelloWorldComponent < Components::Base
  def say_it(string)
    string
  end

  def say_it_with_style(string)
    bolded(string)
  end

  def bolded(string)
    @string = string
    render
  end
end