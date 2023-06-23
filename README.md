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
