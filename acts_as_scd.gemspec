# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "acts_as_scd"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Javier Goizueta", "Matteo Esche"]
  s.date = "2016-09-23"
  s.description = "SCD models have identities and multiple time-limited iterations (revisions) per identity"
  s.email = ["jgoizueta@gmail.com", "webmaster@meinzeug.de"]
  s.files = ["config/locales", "config/locales/acts_as_scd.de.yml", "config/locales/acts_as_scd.en.yml", "lib/acts_as_scd", "lib/acts_as_scd/base_class_methods.rb", "lib/acts_as_scd/block_updater.rb", "lib/acts_as_scd/callbacks.rb", "lib/acts_as_scd/class_methods.rb", "lib/acts_as_scd/date.rb", "lib/acts_as_scd/fixnum.rb", "lib/acts_as_scd/initialize.rb", "lib/acts_as_scd/instance_methods.rb", "lib/acts_as_scd/period.rb", "lib/acts_as_scd/version.rb", "lib/acts_as_scd.rb", "lib/tasks", "lib/tasks/acts_as_scd_tasks.rake", "MIT-LICENSE", "Rakefile", "README.rdoc", "test/controllers", "test/controllers/continents_controller_test.rb", "test/controllers/countries_controller_test.rb", "test/dummy", "test/dummy/app", "test/dummy/app/assets", "test/dummy/app/assets/images", "test/dummy/app/assets/javascripts", "test/dummy/app/assets/javascripts/application.js", "test/dummy/app/assets/stylesheets", "test/dummy/app/assets/stylesheets/application.css", "test/dummy/app/controllers", "test/dummy/app/controllers/application_controller.rb", "test/dummy/app/controllers/concerns", "test/dummy/app/controllers/continents_controller.rb", "test/dummy/app/controllers/countries_controller.rb", "test/dummy/app/helpers", "test/dummy/app/helpers/application_helper.rb", "test/dummy/app/mailers", "test/dummy/app/models", "test/dummy/app/models/callback_model.rb", "test/dummy/app/models/city.rb", "test/dummy/app/models/commercial_delegate.rb", "test/dummy/app/models/concerns", "test/dummy/app/models/continent.rb", "test/dummy/app/models/country.rb", "test/dummy/app/serializers", "test/dummy/app/serializers/city_serializer.rb", "test/dummy/app/serializers/continent_serializer.rb", "test/dummy/app/serializers/country_serializer.rb", "test/dummy/app/views", "test/dummy/app/views/layouts", "test/dummy/app/views/layouts/application.html.erb", "test/dummy/bin", "test/dummy/bin/bundle", "test/dummy/bin/rails", "test/dummy/bin/rake", "test/dummy/config", "test/dummy/config/application.rb", "test/dummy/config/boot.rb", "test/dummy/config/environment.rb", "test/dummy/config/environments", "test/dummy/config/environments/development.rb", "test/dummy/config/environments/production.rb", "test/dummy/config/environments/test.rb", "test/dummy/config/initializers", "test/dummy/config/initializers/backtrace_silencers.rb", "test/dummy/config/initializers/cookies_serializer.rb", "test/dummy/config/initializers/filter_parameter_logging.rb", "test/dummy/config/initializers/inflections.rb", "test/dummy/config/initializers/mime_types.rb", "test/dummy/config/initializers/session_store.rb", "test/dummy/config/initializers/wrap_parameters.rb", "test/dummy/config/locales", "test/dummy/config/locales/de.yml", "test/dummy/config/locales/en.yml", "test/dummy/config/routes.rb", "test/dummy/config/secrets.yml", "test/dummy/config.ru", "test/dummy/lib", "test/dummy/lib/assets", "test/dummy/log", "test/dummy/public", "test/dummy/public/404.html", "test/dummy/public/422.html", "test/dummy/public/500.html", "test/dummy/public/favicon.ico", "test/dummy/Rakefile", "test/dummy/README.rdoc", "test/fixtures", "test/fixtures/callback_models.yml", "test/fixtures/cities.yml", "test/fixtures/continents.yml", "test/fixtures/countries.yml", "test/lib", "test/lib/database_adapter.rb", "test/lib/database_migrations.rb", "test/lib/templates", "test/lib/templates/database.yml.mysql2", "test/lib/templates/database.yml.sqlite3", "test/models", "test/models/acts_as_scd_test.rb", "test/models/callback_model_test.rb", "test/models/continent_test.rb", "test/models/country_test.rb", "test/test_helper.rb"]
  s.homepage = "https://github.com/meinzeugde/acts_as_scd"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.29"
  s.summary = "Support for models that act as Slowly Changing Dimensions"
  s.test_files = ["test/controllers", "test/controllers/continents_controller_test.rb", "test/controllers/countries_controller_test.rb", "test/dummy", "test/dummy/app", "test/dummy/app/assets", "test/dummy/app/assets/images", "test/dummy/app/assets/javascripts", "test/dummy/app/assets/javascripts/application.js", "test/dummy/app/assets/stylesheets", "test/dummy/app/assets/stylesheets/application.css", "test/dummy/app/controllers", "test/dummy/app/controllers/application_controller.rb", "test/dummy/app/controllers/concerns", "test/dummy/app/controllers/continents_controller.rb", "test/dummy/app/controllers/countries_controller.rb", "test/dummy/app/helpers", "test/dummy/app/helpers/application_helper.rb", "test/dummy/app/mailers", "test/dummy/app/models", "test/dummy/app/models/callback_model.rb", "test/dummy/app/models/city.rb", "test/dummy/app/models/commercial_delegate.rb", "test/dummy/app/models/concerns", "test/dummy/app/models/continent.rb", "test/dummy/app/models/country.rb", "test/dummy/app/serializers", "test/dummy/app/serializers/city_serializer.rb", "test/dummy/app/serializers/continent_serializer.rb", "test/dummy/app/serializers/country_serializer.rb", "test/dummy/app/views", "test/dummy/app/views/layouts", "test/dummy/app/views/layouts/application.html.erb", "test/dummy/bin", "test/dummy/bin/bundle", "test/dummy/bin/rails", "test/dummy/bin/rake", "test/dummy/config", "test/dummy/config/application.rb", "test/dummy/config/boot.rb", "test/dummy/config/environment.rb", "test/dummy/config/environments", "test/dummy/config/environments/development.rb", "test/dummy/config/environments/production.rb", "test/dummy/config/environments/test.rb", "test/dummy/config/initializers", "test/dummy/config/initializers/backtrace_silencers.rb", "test/dummy/config/initializers/cookies_serializer.rb", "test/dummy/config/initializers/filter_parameter_logging.rb", "test/dummy/config/initializers/inflections.rb", "test/dummy/config/initializers/mime_types.rb", "test/dummy/config/initializers/session_store.rb", "test/dummy/config/initializers/wrap_parameters.rb", "test/dummy/config/locales", "test/dummy/config/locales/de.yml", "test/dummy/config/locales/en.yml", "test/dummy/config/routes.rb", "test/dummy/config/secrets.yml", "test/dummy/config.ru", "test/dummy/lib", "test/dummy/lib/assets", "test/dummy/log", "test/dummy/public", "test/dummy/public/404.html", "test/dummy/public/422.html", "test/dummy/public/500.html", "test/dummy/public/favicon.ico", "test/dummy/Rakefile", "test/dummy/README.rdoc", "test/fixtures", "test/fixtures/callback_models.yml", "test/fixtures/cities.yml", "test/fixtures/continents.yml", "test/fixtures/countries.yml", "test/lib", "test/lib/database_adapter.rb", "test/lib/database_migrations.rb", "test/lib/templates", "test/lib/templates/database.yml.mysql2", "test/lib/templates/database.yml.sqlite3", "test/models", "test/models/acts_as_scd_test.rb", "test/models/callback_model_test.rb", "test/models/continent_test.rb", "test/models/country_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["<= 4.1.4", ">= 3.2.13"])
      s.add_runtime_dependency(%q<modalsupport>, ["~> 0.9.2"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<json>, ["= 1.8.1"])
      s.add_development_dependency(%q<sqlite3>, ["= 1.3.11"])
      s.add_development_dependency(%q<mysql2>, ["~> 0.3.17"])
      s.add_development_dependency(%q<active_model_serializers>, ["= 0.8.1"])
    else
      s.add_dependency(%q<rails>, ["<= 4.1.4", ">= 3.2.13"])
      s.add_dependency(%q<modalsupport>, ["~> 0.9.2"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<json>, ["= 1.8.1"])
      s.add_dependency(%q<sqlite3>, ["= 1.3.11"])
      s.add_dependency(%q<mysql2>, ["~> 0.3.17"])
      s.add_dependency(%q<active_model_serializers>, ["= 0.8.1"])
    end
  else
    s.add_dependency(%q<rails>, ["<= 4.1.4", ">= 3.2.13"])
    s.add_dependency(%q<modalsupport>, ["~> 0.9.2"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<json>, ["= 1.8.1"])
    s.add_dependency(%q<sqlite3>, ["= 1.3.11"])
    s.add_dependency(%q<mysql2>, ["~> 0.3.17"])
    s.add_dependency(%q<active_model_serializers>, ["= 0.8.1"])
  end
end
