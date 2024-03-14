# frozen_string_literal: true
require 'pagy/extras/bootstrap'
##
module ApplicationHelper
  include Pagy::Frontend
  include Pagy::Backend

  def render_grid(grid)
    pagy, records = grid.assets.is_a?(Array) ? pagy_array(grid.assets) : pagy(grid.assets)

    [
      (datagrid_form_for(grid, url: request.url) if grid.filters.any?),
      datagrid_table(grid, records, html: { class: "table" }, order: false),
      # rubocop:disable Rails/OutputSafety
      (pagy_bootstrap_nav(pagy).html_safe if pagy.pages > 1)
    # rubocop:enable Rails/OutputSafety
    ].compact.reduce(&:+)
  end
end
