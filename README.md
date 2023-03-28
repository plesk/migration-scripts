Custom Migration Scripts
This repository contains the scripts that might be useful in completing various migration-related tasks that are not covered by the standard Plesk Migrator usage scenario.

Structure
The repository structure is the following:

migration-scripts
├── ...
├── deploy-subscriptions
│   ├── deploy-subscriptions.sh
│   ├── README.md
│   └── ...
├── mng-remote-dbs
│   ├── mng-remote-dbs.sh
│   └── README.md
└── ...
Each script is stored in a separate directory. Shell scripts should have .sh suffix in the file name. README.md files placed in respective directories contain information about usage of scripts.

Contribution
Fill free to submit pull requests. Please follow [best practices](https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project).