attrs = [
  { name: :create,
    script: <<-CMD
docker ps
ls
  CMD
  },
  { name: :chckout_brach,
    script: <<-CMD
git checkout %{branch_name}
    CMD
  },
  { name: :start_worker,
    script: <<-CMD
test-queue
    CMD
  },
  { name: :destroy,
    script: <<-CMD
docker rm -f %{dontainar_name}
    CMD
  }
]

TemplateJob.create!(attrs)
