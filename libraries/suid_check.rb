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
    blacklist = default if blacklist.nil?
    @blacklist = blacklist
  end

  def permissions
    output = inspec.command('find / -perm -4000 -o -perm -2000 -type f ! -path \'/proc/*\' ! -path \'/var/lib/lxd/containers/*\' -print 2>/dev/null | grep -v \'^find:\'')
    output.stdout.split(/\r?\n/)
  end

  def diff
    permissions & @blacklist
  end
end
