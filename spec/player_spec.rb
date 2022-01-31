require_relative 'lib/player'

describe Player do
  describe '#valid_column?' do
    subject(:player) { described_class.new('Dima', 'X') }
    before do
      #allow(player.valid_column?).to receive(:column_full?).with(1).and_return(true)
    end
    context 'when player inserts a valid column' do
      it 'should return true' do
        expect(player.valid_column?(2)).to eq(true)
      end
    end
    context 'when player inserts an invalid column' do
      it 'should return false' do
        expect(player.valid_column?(0)).to eq(false)
      end
    end
  end
end