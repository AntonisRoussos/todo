# Be sure to restart your server when you modify this file.

Todo::Application.config.application_locales = Dir.glob("config/locales/*")
Todo::Application.config.task_types = {"Personal" => "P", "Family" => "F", "Study" => "S", "Work" => "W"}
# WillPaginate.per_page = 10
