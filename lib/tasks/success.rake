# frozen_string_literal: true

task success: :environment do
  success = <<'SUCCESS'
  POC BUILD SUCCESSFUL
SUCCESS

  puts success
end
