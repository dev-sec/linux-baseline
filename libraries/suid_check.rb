# author: Christoph Hartmann

class SUIDCheck < Inspec.resource(1)
  name 'suid_check'
  desc 'Use the suid_check resource to verify the current SUID/SGID against a blacklist'
  example "
     describe suid_check(blacklist, exclude_fstypes: %w[nfs nfs4], exclude_paths: %w[/proc]) do
       its('diff') { should be_empty }
     end
   "

  def initialize(blacklist = nil, exclude_fstypes: nil, exclude_paths: nil)
    @blacklist = blacklist
    @exclude_fstypes = exclude_fstypes || default_exclude_fstypes
    @exclude_paths = exclude_paths || default_exclude_paths
  end

  def default_exclude_fstypes
    %w[nfs nfs4 cifs smp nbd ceph]
  end

  def default_exclude_paths
    %w[/sys /proc /var/lib/lxd/containers]
  end

  def permissions
    exclude_opts = exclude_paths.map { |p| "-path #{p} -prune" }.join(' -o ')
    output = inspec.command("find / \\( #{exclude_opts} \\) -o -perm -4000 -perm -2000 -type f -print 2>/dev/null " \
                            "| grep -v '^find:'")
    output.stdout.split(/\r?\n/)
  end

  def exclude_fstype_paths
    mounts = inspec.command('mount')
    mounts.stdout.split("\n").map do |m|
      match = m.match(/ on (?<mount_path>.*) type (?<fstype>\w+) /)
      match['mount_path'] if !match.nil? && @exclude_fstypes.include?(match['fstype'])
    end.compact
  end

  def exclude_paths
    exclude_fstype_paths + @exclude_paths
  end

  def diff
    permissions & @blacklist
  end
end
