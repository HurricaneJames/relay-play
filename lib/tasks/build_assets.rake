namespace :assets do
  desc 'build all the assets (use instead of assets:precompile to get the react components)'
  task :build do
    Rake::Task['assets:clean'].invoke
    system('npm run build')
    Rake::Task['assets:precompile'].invoke
  end
end