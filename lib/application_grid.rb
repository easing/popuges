class ApplicationGrid
  include Datagrid

  def self.column(name, query = nil, **options, &block)
    if name == :id
      options[:html] = true
      block = proc { |record| link_to(record.id, record) rescue record.id }
    end

    super(name, query = nil, **options, &block)
  end
end