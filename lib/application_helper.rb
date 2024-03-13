# frozen_string_literal: true

##
module ApplicationHelper
  def render_grid(grid)
    datagrid_table(grid, html: { class: "table" }, order: false)
  end
end
