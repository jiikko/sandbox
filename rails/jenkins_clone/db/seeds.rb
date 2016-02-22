attrs = [
  { name: :create,
    body: <<-CMD
docker ps
ls
  CMD
  },
  { name: :chckout_brach,
    dependency_cmds: [:create],
    body: <<-CMD
git checkout %{branch_name}
    CMD
  },
  { name: :start_worker,
    dependency_cmds: [:create],
    body: <<-CMD
test-queue
    CMD
  },
  { name: :destroy,
    dependency_cmds: [:create],
    body: <<-CMD
docker rm -f %{dontainar_name}
    CMD
  }
]

CommandTemplate.create!(attrs)
