# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.11.2'

# Capistranoのログの表示に利用する
set :application, 'classEnglishApp'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:keishi1129/classEnglishApp.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push("config/master.key")

set :rbenv_type, :user
set :rbenv_ruby, '2.6.4' 

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/english_app_key.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# --prefer-offline -> 高速化
# --production -> devDependencies にあるパッケージはインストールしなくなる
# --no-progress -> progress bar の非表示
set :yarn_flags, "--prefer-offline --production --no-progress"
set :yarn_roles, :app
set :yarn_bin, '~/.yarn/bin/yarn'

# Rake::Task["deploy:assets:precompile"].clear
# after 'deploy:updated', 'webpacker:precompile'
# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

 