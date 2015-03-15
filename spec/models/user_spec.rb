require 'spec_helper'

describe User do
  before { @user = FG.build(:user) }

  subject { @user }

  it { expect(subject).to respond_to(:name) }
  it { expect(subject).to respond_to(:icon) }
  it { expect(subject).to respond_to(:selection_count) }
end
