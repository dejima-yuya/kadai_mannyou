# README

## user モデル
| Column             | Type   |
| ------------------ | ------ |
| name               | string |
| email              | string |
| password_digest    | string |

### Association

- has_many :tasks

## task モデル
| Column    | Type   |
| --------- | ------ |
| title     | string |
| content   | text   |

### Association

- belongs_to :user
- has_many :labels_tasks

## label_task モデル
| Column    | Type   |
| --------- | ------ |

### Association

- belongs_to :label
- belongs_to :task

## label モデル
| Column    | Type   |
| --------- | ------ |
| title     | string |

### Association

- has_many :labels_tasks

## Heroku へのデプロイ手順

- heroku create コマンドを実行して Heroku に新しいアプリケーションを作成する。
- 「net-smtp」「net-imap」「net-pop」の3つの gem をインストールする

- git add と git commit を行う

### Heroku buildpack と PostgreSQL のアドオンを追加する
- heroku buildpacks:set heroku/ruby コマンドを実行する
- heroku buildpacks:add --index 1 heroku/nodejs コマンドを実行する
- heroku addons:create heroku-postgresql コマンドを実行する

### step2ブランチで作業を行っていたので、step2ブランチでの変更内容を Heroku の masterブランチに反映する。
- git push heroku step2:master コマンドを実行する

### マイグレーションを実行する
- heroku run rails db:migrate コマンドを実行する
