module ActsAsScd

  class Period

    class DateValue
      def initialize(d)

        d = d.strftime('%Y%m%d') if d.respond_to?(:strftime)
        if String===d && d =~ /\A(\d\d\d\d)-(\d\d)-(\d\d)\Z/
          d = $1.to_i*10000 + $2.to_i*100 + $3.to_i
        end
        @value = d && d.to_i
      end

      attr_reader :value

      def to_date
        begin
          Date.new *parse
        rescue
          raise parse.inspect
        end
      end

      def to_date_formatted(strftime_format='%Y-%m-%d')
        to_date.strftime(strftime_format)
      end

      def parse
        y = @value/10000
        v = @value%10000

        m = v/100
        m = 1 if m < 1
        m = 12 if m > 12

        d = v%100
        d = 1 if d < 1
        d = 31 if d > 31

        [y,m,d]
      end

      def to_s
        y,m,d = parse
        I18n.l Date.new(y, m, d)
      end

      include ModalSupport::BracketConstructor
    end

    def self.date(date)
      DateValue[date].value
    end

    def self.date_to_s(date)
      DateValue[date].to_s
    end

    attr_reader :start, :end
    def from
      @start
    end
    def to
      @end
    end

    def initialize(from, to)
      @start = Period.date(from || START_OF_TIME)
      @end = Period.date(to || END_OF_TIME)
    end

    include ModalSupport::StateEquivalent
    include ModalSupport::BracketConstructor

    def to_s(options={})
      if @start<=START_OF_TIME
        if @end>=END_OF_TIME
          options[:always] || I18n.t(:"scd.period.always") || '-'
        else
          "#{options[:until] || I18n.t(:"scd.period.until") || 'to'} #{Period.date_to_s(@end)}"
        end
      else
        if @end>=END_OF_TIME
          "#{options[:since] || I18n.t(:"scd.period.from") || 'since'} #{Period.date_to_s(@start)}"
        else
          [Period.date_to_s(@start), options[:between] ||  I18n.t(:"scd.period.between") || '-', Period.date_to_s(@end)].compact*' '
        end
      end
    end

    def includes?(date)
      date = Period.date(date)
      @start <= date && date < @end
    end
    alias_method :at_date?, :includes?

    def valid?
      @start < @end
    end

    def empty?
      @start >= @end
    end
    alias_method :invalid?, :empty?

    def past_limited?
      @start > START_OF_TIME
    end
    alias_method :limited_start?, :past_limited?

    def future_limited?
      @end < END_OF_TIME
    end
    alias_method :limited_end?, :future_limited?

    def limited?
      past_limited? || future_limited?
    end

    def unlimited?
      !past_limited? && !future_limited?
    end

    def initial?
      @start == START_OF_TIME
    end
    alias_method :unlimited_start?, :initial?

    def current?
      @end == END_OF_TIME
    end
    alias_method :unlimited_end?, :current?

    def at_present?
      includes?(Date.today)
    end

    def overlap?(period)
      (@start < period.end || @end > period.start)
    end

    def reference_date
      if @start <= START_OF_TIME
        if @end >= END_OF_TIME
          # return present date (today) if 'effective_from' = 0 and 'effective_to' = 99999999
          DateValue[Date.today].value
        else
          # return end date of a period if 'effective_from' = 0 and 'effective_to' < 99999999
          DateValue[DateValue[@end].to_date - 1].value
        end
      else
        # return specific start date if 'effective_from' > 0
        @start
      end
    end

    def reference_date_formatted(strftime_format='%Y-%m-%d')
      DateValue[reference_date].to_date_formatted(strftime_format)
    end

    def formatted(strftime_format='%Y-%m-%d')
      {
          :start => DateValue[@start].to_date_formatted(strftime_format),
          :end => DateValue[@end].to_date_formatted(strftime_format),
          :reference => reference_date_formatted(strftime_format)
      }
    end

  end

end
