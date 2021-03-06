# Manage AIO based Marionette Collective
#
# @param plugintypes The list of plugin directories to create under libdir
# @param plugin_classes The list of plugins to install via classes
# @param plugin_classes_exclude A list of plugins not to install
# @param server_config A hash of config items to set in the server.cfg
# @param client_config A hash of config items to set in the client.cfg
# @param common_config A hash of config items to set in both client.cfg and server.cfg
# @param libdir The directory where plugins will go in
# @param configdir Root directory to config files
# @param facts_refresh_interval Minutes between fact refreshes, set to 0 to disable cron based refreshes
# @param rubypath Path to the ruby executable
# @param collectives A list of collectives the node belongs to
# @param client_collectives A list of collectives the client has access to, defaults to the same as the node
# @param main_collective The main collective to use, last in the list of `$collectives` by default
# @param client_main_collective The main collective to use on the client, `$main_collective` by default
# @param plugin_owner The default user who will own plugin files
# @param plugin_group The default group who will own plugin files
# @param plugin_mode The default mode plugin files will have
# @param policy_default When managing plugin policies this will be the default allow/deny
# @param site_policies Policies to apply to all agents after any module specific policies
# @param rpcutil_policies Policies to apply to the special rpcutil agent
# @param service_ensure Ensure value for the service
# @param service_name The mcollective service name to notify and manage
# @param service_enable The enable value for the service
# @param client Install client files on this node
# @param server Install server files on this node
class mcollective (
  Array[String] $plugintypes,
  Array[String] $plugin_classes,
  Array[String] $plugin_classes_exclude = [],
  Hash $server_config = {},
  Hash $client_config = {},
  Hash $common_config = {},
  String $libdir,
  String $configdir,
  String $rubypath,
  Integer $facts_refresh_interval,
  Array[Mcollective::Collective] $collectives,
  Array[Mcollective::Collective] $client_collectives = $collectives,
  Optional[Mcollective::Collective] $main_collective = undef,
  Optional[Mcollective::Collective] $client_main_collective = undef,
  Optional[String] $plugin_owner,
  Optional[String] $plugin_group,
  Optional[String] $plugin_mode,
  Mcollective::Policy_action $policy_default,
  Array[Mcollective::Policy] $site_policies = [],
  Array[Mcollective::Policy] $rpcutil_policies = [],
  Enum["stopped", "running"] $service_ensure,
  String $service_name,
  Boolean $service_enable,
  Boolean $client,
  Boolean $server
) {
  $factspath = "${configdir}/facts.yaml"

  include mcollective::plugin_dirs
  include mcollective::config
  include mcollective::facts
  include mcollective::service

  include $plugin_classes - $plugin_classes_exclude
}

