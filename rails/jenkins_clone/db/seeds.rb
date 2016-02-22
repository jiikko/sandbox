CommandTemplate.create!(
  name: :build_containar,
  body: <<-CMD
docker ps
  CMD
)
