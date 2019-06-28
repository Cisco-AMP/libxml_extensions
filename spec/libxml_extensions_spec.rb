require 'libxml_extensions'

describe LibxmlExtensions::DecoratedDocument do
  let(:doc) do
    doc = described_class.new(LibXML::XML::Document.new('doc'))
    doc.root = LibXML::XML::Node.new 'root'
    doc
  end

  describe '#add_xml_node_and_value' do
    it 'trails the leading slash' do
      doc.add_xml_node_and_value('/path', 10)
      expect(doc.find_first('path').inner_xml).to eql("10")
    end

    it 'creates all the intermediate paths' do
      doc.add_xml_node_and_value('some/long/path', 10)
      expect(doc.find_first('some/long/path').inner_xml).to eql("10")
    end

    it 'accepts arrays' do
      doc.add_xml_node_and_value('some/long/path', [10, 11])
      expect(doc.find('some/long/path').map(&:inner_xml)).to eql(['10', '11'])
    end

    it 'accepts hashes and arrays' do
      doc.add_xml_node_and_value('some/long/path', [{a: 10, b: [20, 30]}])
      expect(doc.find_first('some/long/path/a').inner_xml).to eql('10')
      expect(doc.find('some/long/path/b').map(&:inner_xml)).to eql(['20', '30'])
    end

  end
end
