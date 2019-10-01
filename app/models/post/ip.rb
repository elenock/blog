# frozen_string_literal: true

class Post::Ip < AbstractService
  include ActiveRecord::Sanitization::ClassMethods

  attr_reader :ip_data

  def initialize
    @ip_data = []
  end

  def run
    # return AbstractService::FailResult.new('list invalid') unless valid?
    tmp = ActiveRecord::Base.connection.execute(
      sanitize_sql(
        <<-SQL
          SELECT DISTINCT
            ip,
            user_id
            FROM (
              SELECT
                ip,
                user_id,
                last_value(Row) OVER(PARTITION BY ip ORDER BY ip asc) as Count
                FROM(
                  SELECT
                    ip,
                    user_id,
                    ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip asc )AS Row
                    FROM (
                      SELECT DISTINCT
                        ip,
                        user_id
                        FROM posts ORDER BY ip
                    ) as table1
                ) as table2
              ) as table3
              WHERE (Count > 1) ORDER BY ip;
        SQL
      )
    )

    return AbstractService::FailResult.new('data error') unless tmp.count != 0

    user_data = []
    ip = tmp.first['ip']
    last = tmp.to_a.last

    tmp.map do |string|
      if ip != string['ip'] || last == string
        user_data << string['user_id'] if last == string
        ip_data << { ip: ip, users: user_data }
        user_data = []
        ip = string['ip']
      end
      user_data << string['user_id']
    end

    AbstractService::SuccesResult.new(ip_data)
  end
end