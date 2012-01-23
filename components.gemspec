# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{components}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lance Ivy", "Alexander Lang"]
  s.date = %q{2009-06-19}
  s.email = %q{alex@upstream-berlin.com}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".document",
    ".gitignore",
    "MIT-LICENSE",
    "README.md",
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
    "test/action_controller_test.rb",
    "test/r3/app/components/child/one.erb",
    "test/r3/app/components/child_component.rb",
    "test/r3/app/components/hello_world/bolded.erb",
    "test/r3/app/components/hello_world/say_it_with_help.erb",
    "test/r3/app/components/hello_world_component.rb",
    "test/r3/app/components/parent/one.erb",
    "test/r3/app/components/parent/two.erb",
    "test/r3/app/components/parent_component.rb",
    "test/r3/app/components/rich_view/form.erb",
    "test/r3/app/components/rich_view/linker.erb",
    "test/r3/app/components/rich_view/urler.erb",
    "test/r3/app/components/rich_view_component.rb",
    "test/r3/app/controllers/application_controller.rb",
    "test/r3/app/controllers/hello_world_controller.rb",
    "test/caching_test.rb",
    "test/components_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/langalex/components}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.summary = "Rails components with inheritable views, caching, and good encapsulation."
  s.rubygems_version = %q{1.3.1}
  s.test_files = [
    "test/action_controller_test.rb",
    "test/r3/app/components/child_component.rb",
    "test/r3/app/components/hello_world_component.rb",
    "test/r3/app/components/parent_component.rb",
    "test/r3/app/components/rich_view_component.rb",
    "test/r3/app/controllers/application_controller.rb",
    "test/r3/app/controllers/hello_world_controller.rb",
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
