class FarMar::Market
  attr_accessor :id,
                :name,
                :address,
                :city,
                :county,
                :state,
                :zip

  def initialize(attrs)
    @id      = attrs[:id]
    @name    = attrs[:name]
    @address = attrs[:address]
    @city    = attrs[:city]
    @county  = attrs[:county]
    @state   = attrs[:state]
    @zip     = attrs[:zip]
  end

  def self.path
    "support/markets.csv"
  end

  def self.all
    CSV.read(path).map do |line|
      new(
        id:      line[0].to_i,
        name:    line[1],
        address: line[2],
        city:    line[3],
        county:  line[4],
        state:   line[5],
        zip:     line[6]
      )
    end
  end

  def self.find(id)
    all.find do |obj|
      obj.id == id
    end
  end

  def vendors
    list = FarMar::Vendor.all
    ans = list.group_by do |obj|
      obj.market_id
    end
    ans[id]
  end

  def self.find_by_state(state_name)
    all.find do |obj|
      obj.state == state_name
    end
  end

  def self.find_all_by_state(state_name)
    all.find_all do |obj|
      obj.state == state_name
    end
  end

end
