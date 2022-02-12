# frozen_string_literal: true

# author: Christoph Hartmann

class SUIDCheck < Inspec.resource(1)
  name 'suid_check'
  desc 'Use the suid_check resource to verify the current SUID/SGID against a blacklist'
  example "
     describe suid_check(blacklist) do
       its('diff') { should be_empty }
     end
   "

  def initialize(blacklist = nil)
    super()
    blacklist = default if blacklist.nil?
    @blacklist = blacklist
  end

  def permissions
    output = inspec.command('find / -type d \( -path \'/proc/*\' -o -path \'/var/lib/lxd/containers/*\' \) -prune -type f -o -perm -2000 -o -perm 4000 2>/dev/null | grep -v \'^find:\'')
    output.stdout.split(/\r?\n/)
  end

  def diff
    permissions & @blacklist
  end
end
