# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{components}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lance Ivy", "Alexander Lang"]
  s.date = %q{2009-06-19}
  s.email = %q{alex@upstream-berlin.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "MIT-LICENSE",
     "README",
     "Rakefile",
     "VERSION.yml",
     "components.gemspec",
     "generators/component/component_generator.rb",
     "generators/component/templates/component_template.rb",
     "generators/component/templates/view_template.rb",
     "lib/components.rb",
     "lib/components/base.rb",
     "lib/components/caching.rb",
     "lib/components/helpers.rb",
     "lib/components/view.rb",
     "rails/init.rb",
     "test/action_controller_test.rb",
     "test/app/components/child/one.erb",
     "test/app/components/child_component.rb",
     "test/app/components/hello_world/bolded.erb",
     "test/app/components/hello_world/say_it_with_help.erb",
     "test/app/components/hello_world_component.rb",
     "test/app/components/parent/one.erb",
     "test/app/components/parent/two.erb",
     "test/app/components/parent_component.rb",
     "test/app/components/rich_view/form.erb",
     "test/app/components/rich_view/linker.erb",
     "test/app/components/rich_view/urler.erb",
     "test/app/components/rich_view_component.rb",
     "test/app/controllers/application_controller.rb",
     "test/app/controllers/hello_world_controller.rb",
     "test/caching_test.rb",
     "test/components_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/langalex/components}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/action_controller_test.rb",
     "test/app/components/child_component.rb",
     "test/app/components/hello_world_component.rb",
     "test/app/components/parent_component.rb",
     "test/app/components/rich_view_component.rb",
     "test/app/controllers/application_controller.rb",
     "test/app/controllers/hello_world_controller.rb",
     "test/caching_test.rb",
     "test/components_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
