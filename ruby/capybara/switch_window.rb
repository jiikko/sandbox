old_window = Capybara.current_window
new_window = Capybara.open_new_window
Capybara.switch_to_window(new_window)
visit "/top"
