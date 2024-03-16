# frozen_string_literal: true

##
class ApplicationGrid
  include Datagrid

  def self.column(name, _query = nil, **options, &block)
    if name == :id
      options[:html] = true
      block = proc { |record|
                begin
                  link_to(record.id, record)
                rescue
                  record.id
                end }
    end

    super(name, nil, **options, &block)
  end
end
