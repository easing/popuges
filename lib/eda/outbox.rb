# frozen_string_literal: true

##
class EDA::Outbox < ActiveRecord::Base
  self.table_name = :eda_outbox
end
