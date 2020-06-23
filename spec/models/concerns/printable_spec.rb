require 'rails_helper'

describe Printable, type: :model do
  create_spec_table :printable_tests do |t|
    t.string :name
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
