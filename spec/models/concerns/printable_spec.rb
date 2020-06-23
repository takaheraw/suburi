require 'rails_helper'

describe Printable, type: :model do
  before(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table :printable_tests do |t|
      t.string :name
    end
  end

  after(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table :printable_tests
  end

  class PrintableTest < ApplicationRecord
    include Printable
  end

  before do
    record.save
  end

  describe '#print_name' do
    let(:record) { PrintableTest.new(name: 'hoge') }

    subject { record.print_name }

    it do
      expect(record.name).to eq("hoge")
      expect { subject }.to output("hoge\n").to_stdout
    end
  end
end
