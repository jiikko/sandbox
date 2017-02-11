require "mysql2"
require "active_record"
require 'date'

config = {
  user: :root,
  password: "",
  :adapter   => "mysql2",
  :encoding  => "utf8",
  :reconnect => true,
  :pool      => 5,
  :database  => 'sql_drill'
}
ActiveRecord::Base.establish_connection(config)

# for name in `echo "show tables;" | mysql -uroot sql_drill` for; echo "class $name <  ActiveRecord::Base;   self.table_name = '$name'; end"
class BelongTo <  ActiveRecord::Base;   self.table_name = 'BelongTo'; end
class Categories <  ActiveRecord::Base;   self.table_name = 'Categories'; end
class CustomerClasses <  ActiveRecord::Base;   self.table_name = 'CustomerClasses'; end
class Customers <  ActiveRecord::Base;   self.table_name = 'Customers'; end
class Departments <  ActiveRecord::Base;   self.table_name = 'Departments'; end
class Employees <  ActiveRecord::Base;   self.table_name = 'Employees'; end
class Prefecturals <  ActiveRecord::Base;   self.table_name = 'Prefecturals'; end
class Products <  ActiveRecord::Base;   self.table_name = 'Products'; end
class Salary <  ActiveRecord::Base;   self.table_name = 'Salary'; end
class Sales <  ActiveRecord::Base;   self.table_name = 'Sales'; end
