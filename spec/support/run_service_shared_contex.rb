shared_examples 'run service' do
  let(:result) { OpenStruct.new(success?: true) }

  before do
    allow(klass).to receive(:call).and_return(result)
    action.call
  end

  it 'service called' do
    expect(klass).to have_received(:call)
  end

  it 'success response' do
    expect(response).to be_successful
  end

  context 'when service failure' do
    let(:result) { OpenStruct.new(success?: false) }

    it 'un-success response' do
      expect(response).not_to be_successful
    end
  end
end
