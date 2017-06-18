module derelict.git2.type;

import derelict.util.system : MakeEnum;
import std.conv : octal;

extern(C) nothrow:

// attr.h
enum git_attr_t {
	GIT_ATTR_UNSPECIFIED_T,
	GIT_ATTR_TRUE_T,
	GIT_ATTR_FALSE_T,
	GIT_ATTR_VALUE_T
}
mixin(MakeEnum!git_attr_t);

enum GIT_ATTR_CHECK_FILE_THEN_INDEX = 0;
enum GIT_ATTR_CHECK_INDEX_THEN_FILE = 1;
enum GIT_ATTR_CHECK_INDEX_ONLY = 2;
enum GIT_ATTR_CHECK_NO_SYSTEM = (1 << 2);

alias git_attr_foreach_cb = int function(const(char)* name, const(char)* value, void* payload);

// blame.h
enum git_blame_flag_t {
	GIT_BLAME_NORMAL = 0,
	GIT_BLAME_TRACK_COPIES_SAME_FILE = (1<<0),
	GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES = (1<<1),
	GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES = (1<<2),
	GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES = (1<<3),
	GIT_BLAME_FIRST_PARENT = (1<<4),
}
mixin(MakeEnum!git_blame_flag_t);

struct git_blame_options {
	uint version_;
	uint flags;
	ushort min_match_characters;
	git_oid newest_commit;
	git_oid oldest_commit;
	size_t min_line;
	size_t max_line;
}

struct git_blame_hunk {
	size_t lines_in_hunk;
	git_oid final_commit_id;
	size_t final_start_line_number;
	git_signature* final_signature;
	git_oid orig_commit_id;
	const(char)* orig_path;
	size_t orig_start_line_number;
	git_signature* orig_signature;
	char boundary;
}

struct git_blame;

enum GIT_BLAME_OPTIONS_VERSION = 1;

// branch.h
struct git_branch_iterator;

// buffer.h
struct git_buf {
	char* ptr;
	size_t asize, size;
}

// checkout.h

enum GIT_CHECKOUT_OPTIONS_VERSION = 1;

enum git_checkout_strategy_t {
	GIT_CHECKOUT_NONE = 0,
	GIT_CHECKOUT_SAFE = (1u << 0),
	GIT_CHECKOUT_FORCE = (1u << 1),
	GIT_CHECKOUT_RECREATE_MISSING = (1u << 2),
	GIT_CHECKOUT_ALLOW_CONFLICTS = (1u << 4),
	GIT_CHECKOUT_REMOVE_UNTRACKED = (1u << 5),
	GIT_CHECKOUT_REMOVE_IGNORED = (1u << 6),
	GIT_CHECKOUT_UPDATE_ONLY = (1u << 7),
	GIT_CHECKOUT_DONT_UPDATE_INDEX = (1u << 8),
	GIT_CHECKOUT_NO_REFRESH = (1u << 9),
	GIT_CHECKOUT_SKIP_UNMERGED = (1u << 10),
	GIT_CHECKOUT_USE_OURS = (1u << 11),
	GIT_CHECKOUT_USE_THEIRS = (1u << 12),
	GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH = (1u << 13),
	GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES = (1u << 18),
	GIT_CHECKOUT_DONT_OVERWRITE_IGNORED = (1u << 19),
	GIT_CHECKOUT_CONFLICT_STYLE_MERGE = (1u << 20),
	GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 = (1u << 21),
	GIT_CHECKOUT_DONT_REMOVE_EXISTING = (1u << 22),
	GIT_CHECKOUT_DONT_WRITE_INDEX = (1u << 23),
	GIT_CHECKOUT_UPDATE_SUBMODULES = (1u << 16),
	GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED = (1u << 17),
}
mixin(MakeEnum!git_checkout_strategy_t);

enum git_checkout_notify_t {
	GIT_CHECKOUT_NOTIFY_NONE      = 0,
	GIT_CHECKOUT_NOTIFY_CONFLICT  = (1u << 0),
	GIT_CHECKOUT_NOTIFY_DIRTY     = (1u << 1),
	GIT_CHECKOUT_NOTIFY_UPDATED   = (1u << 2),
	GIT_CHECKOUT_NOTIFY_UNTRACKED = (1u << 3),
	GIT_CHECKOUT_NOTIFY_IGNORED   = (1u << 4),
	GIT_CHECKOUT_NOTIFY_ALL       = 0x0FFFFu
}
mixin(MakeEnum!git_checkout_notify_t);

struct git_checkout_perfdata {
	size_t mkdir_calls;
	size_t stat_calls;
	size_t chmod_calls;
}

alias git_checkout_notify_cb = int function(
	git_checkout_notify_t why,
	const(char)* path,
	const(git_diff_file)* baseline,
	const(git_diff_file)* target,
	const(git_diff_file)* workdir,
	void* payload);

alias git_checkout_progress_cb = void function(
	const(char)* path,
	size_t completed_steps,
	size_t total_steps,
	void* payload);

alias git_checkout_perfdata_cb = void function(
	const(git_checkout_perfdata)* perfdata,
	void* payload);

struct git_checkout_options {
	uint version_;
	uint checkout_strategy;
	int disable_filters;
	uint dir_mode;
	uint file_mode;
	int file_open_flags;
	uint notify_flags;
	git_checkout_notify_cb notify_cb;
	void* notify_payload;
	git_checkout_progress_cb progress_cb;
	void* progress_payload;
	git_strarray paths;
	git_tree* baseline;
	git_index* baseline_index;
	const(char)*target_directory;
	const(char)*ancestor_label;
	const(char)*our_label;
	const(char)*their_label;
	git_checkout_perfdata_cb perfdata_cb;
	void* perfdata_payload;
}

// cherrypick.h
struct git_cherrypick_options {
	uint version_;
	uint mainline;
	git_merge_options merge_opts;
	git_checkout_options checkout_opts;
}

enum GIT_CHERRYPICK_OPTIONS_VERSION = 1;

// clone.h

enum GIT_CLONE_OPTIONS_VERSION = 1;

enum git_clone_local_t {
	GIT_CLONE_LOCAL_AUTO,
	GIT_CLONE_LOCAL,
	GIT_CLONE_NO_LOCAL,
	GIT_CLONE_LOCAL_NO_LINKS,
}
mixin(MakeEnum!git_clone_local_t);

alias git_remote_create_cb = int function(
	git_remote** out_,
	git_repository* repo,
	const(char)* name,
	const(char)* url,
	void* payload);

alias git_repository_create_cb = int function(
	git_repository** out_,
	const(char)* path,
	int bare,
	void* payload);

struct git_clone_options {
	uint version_;
	git_checkout_options checkout_opts;
	git_fetch_options fetch_opts;
	int bare;
	git_clone_local_t local;
	const(char)* checkout_branch;
	git_repository_create_cb repository_cb;
	void* repository_cb_payload;
	git_remote_create_cb remote_cb;
	void* remote_cb_payload;
}

// common.h
enum git_feature_t {
	GIT_FEATURE_THREADS	= (1 << 0),
	GIT_FEATURE_HTTPS	= (1 << 1),
	GIT_FEATURE_SSH		= (1 << 2),
	GIT_FEATURE_NSEC	= (1 << 3),
}
mixin(MakeEnum!git_feature_t);

enum git_libgit2_opt_t {
	GIT_OPT_GET_MWINDOW_SIZE,
	GIT_OPT_SET_MWINDOW_SIZE,
	GIT_OPT_GET_MWINDOW_MAPPED_LIMIT,
	GIT_OPT_SET_MWINDOW_MAPPED_LIMIT,
	GIT_OPT_GET_SEARCH_PATH,
	GIT_OPT_SET_SEARCH_PATH,
	GIT_OPT_SET_CACHE_OBJECT_LIMIT,
	GIT_OPT_SET_CACHE_MAX_SIZE,
	GIT_OPT_ENABLE_CACHING,
	GIT_OPT_GET_CACHED_MEMORY,
	GIT_OPT_GET_TEMPLATE_PATH,
	GIT_OPT_SET_TEMPLATE_PATH,
	GIT_OPT_SET_SSL_CERT_LOCATIONS,
	GIT_OPT_SET_USER_AGENT,
	GIT_OPT_ENABLE_STRICT_OBJECT_CREATION,
	GIT_OPT_SET_SSL_CIPHERS,
	GIT_OPT_GET_USER_AGENT,
}
mixin(MakeEnum!git_libgit2_opt_t);

enum GIT_PATH_MAX = 4096;

version(Windows) {
	enum GIT_PATH_LIST_SEPARATOR = ';';
} else {
	enum GIT_PATH_LIST_SEPARATOR = ':';
}

enum GIT_OID_HEX_ZERO = "0000000000000000000000000000000000000000";

// config.h
enum git_config_level_t {
	GIT_CONFIG_LEVEL_PROGRAMDATA = 1,
	GIT_CONFIG_LEVEL_SYSTEM = 2,
	GIT_CONFIG_LEVEL_XDG = 3,
	GIT_CONFIG_LEVEL_GLOBAL = 4,
	GIT_CONFIG_LEVEL_LOCAL = 5,
	GIT_CONFIG_LEVEL_APP = 6,
	GIT_CONFIG_HIGHEST_LEVEL = -1,
}
mixin(MakeEnum!git_config_level_t);

struct git_config_entry {
	const(char)* name;
	const(char)* value;
	git_config_level_t level;
	void function(git_config_entry* entry) free;
	void* payload;
}

alias git_config_foreach_cb = int function(const(git_config_entry)*, void*);

struct git_config_iterator;

enum git_cvar_t {
	GIT_CVAR_FALSE = 0,
	GIT_CVAR_TRUE = 1,
	GIT_CVAR_INT32,
	GIT_CVAR_STRING
}
mixin(MakeEnum!git_cvar_t);

struct git_cvar_map {
	git_cvar_t cvar_type;
	const(char)* str_match;
	int map_value;
}

// cred_helpers.h

struct git_cred_userpass_payload {
	const(char)* username;
	const(char)* password;
}

// describe.h

enum git_describe_strategy_t {
	GIT_DESCRIBE_DEFAULT,
	GIT_DESCRIBE_TAGS,
	GIT_DESCRIBE_ALL,
}
mixin(MakeEnum!git_describe_strategy_t);

struct git_describe_options {
	uint version_;
	uint max_candidates_tags;
	uint describe_strategy;
	const(char)* pattern;
	int only_follow_first_parent;
	int show_commit_oid_as_fallback;
}

struct git_describe_format_options {
	uint version_;
	uint abbreviated_size;
	int always_use_long_format;
	const(char)* dirty_suffix;
}

struct git_describe_result;

enum GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS = 10;
enum GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE = 7;
enum GIT_DESCRIBE_OPTIONS_VERSION = 1;
enum GIT_DESCRIBE_FORMAT_OPTIONS_VERSION = 1;

// diff.h

enum git_diff_option_t {
	GIT_DIFF_NORMAL = 0,
	GIT_DIFF_REVERSE = (1u << 0),
	GIT_DIFF_INCLUDE_IGNORED = (1u << 1),
	GIT_DIFF_RECURSE_IGNORED_DIRS = (1u << 2),
	GIT_DIFF_INCLUDE_UNTRACKED = (1u << 3),
	GIT_DIFF_RECURSE_UNTRACKED_DIRS = (1u << 4),
	GIT_DIFF_INCLUDE_UNMODIFIED = (1u << 5),
	GIT_DIFF_INCLUDE_TYPECHANGE = (1u << 6),
	GIT_DIFF_INCLUDE_TYPECHANGE_TREES = (1u << 7),
	GIT_DIFF_IGNORE_FILEMODE = (1u << 8),
	GIT_DIFF_IGNORE_SUBMODULES = (1u << 9),
	GIT_DIFF_IGNORE_CASE = (1u << 10),
	GIT_DIFF_INCLUDE_CASECHANGE = (1u << 11),
	GIT_DIFF_DISABLE_PATHSPEC_MATCH = (1u << 12),
	GIT_DIFF_SKIP_BINARY_CHECK = (1u << 13),
	GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS = (1u << 14),
	GIT_DIFF_UPDATE_INDEX = (1u << 15),
	GIT_DIFF_INCLUDE_UNREADABLE = (1u << 16),
	GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED = (1u << 17),
	GIT_DIFF_FORCE_TEXT = (1u << 20),
	GIT_DIFF_FORCE_BINARY = (1u << 21),
	GIT_DIFF_IGNORE_WHITESPACE = (1u << 22),
	GIT_DIFF_IGNORE_WHITESPACE_CHANGE = (1u << 23),
	GIT_DIFF_IGNORE_WHITESPACE_EOL = (1u << 24),
	GIT_DIFF_SHOW_UNTRACKED_CONTENT = (1u << 25),
	GIT_DIFF_SHOW_UNMODIFIED = (1u << 26),
	GIT_DIFF_PATIENCE = (1u << 28),
	GIT_DIFF_MINIMAL = (1 << 29),
	GIT_DIFF_SHOW_BINARY = (1 << 30),
}
mixin(MakeEnum!git_diff_option_t);

struct git_diff;

enum git_diff_flag_t {
	GIT_DIFF_FLAG_BINARY     = (1u << 0),
	GIT_DIFF_FLAG_NOT_BINARY = (1u << 1),
	GIT_DIFF_FLAG_VALID_ID   = (1u << 2),
	GIT_DIFF_FLAG_EXISTS     = (1u << 3),
}
mixin(MakeEnum!git_diff_flag_t);

enum git_delta_t {
	GIT_DELTA_UNMODIFIED = 0,
	GIT_DELTA_ADDED = 1,
	GIT_DELTA_DELETED = 2,
	GIT_DELTA_MODIFIED = 3,
	GIT_DELTA_RENAMED = 4,
	GIT_DELTA_COPIED = 5,
	GIT_DELTA_IGNORED = 6,
	GIT_DELTA_UNTRACKED = 7,
	GIT_DELTA_TYPECHANGE = 8,
	GIT_DELTA_UNREADABLE = 9,
	GIT_DELTA_CONFLICTED = 10,
}
mixin(MakeEnum!git_delta_t);

struct git_diff_file {
	git_oid id;
	const(char)* path;
	git_off_t size;
	uint flags;
	ushort mode;
	ushort id_abbrev;
}

struct git_diff_delta {
	git_delta_t status;
	uint flags;
	ushort similarity;
	ushort nfiles;
	git_diff_file old_file;
	git_diff_file new_file;
}

alias git_diff_notify_cb = int function(
	const(git_diff)* diff_so_far,
	const(git_diff_delta)* delta_to_add,
	const(char)* matched_pathspec,
	void* payload);

alias git_diff_progress_cb = int function(
	const(git_diff)* diff_so_far,
	const(char)* old_path,
	const(char)* new_path,
	void* payload);

struct git_diff_options {
	uint version_;
	uint flags;
	git_submodule_ignore_t ignore_submodules;
	git_strarray pathspec;
	git_diff_notify_cb notify_cb;
	git_diff_progress_cb progress_cb;
	void* payload;
	uint context_lines;
	uint interhunk_lines;
	ushort id_abbrev;
	git_off_t max_size;
	const(char)* old_prefix;
	const(char)* new_prefix;
}

alias git_diff_file_cb = int function(
	const(git_diff_delta)* delta,
	float progress,
	void* payload);

enum GIT_DIFF_HUNK_HEADER_SIZE = 128;

enum git_diff_binary_t {
	GIT_DIFF_BINARY_NONE,
	GIT_DIFF_BINARY_LITERAL,
	GIT_DIFF_BINARY_DELTA,
}
mixin(MakeEnum!git_diff_binary_t);

struct git_diff_binary_file {
	git_diff_binary_t type;
	const(char)* data;
	size_t datalen;
	size_t inflatedlen;
}

struct git_diff_binary {
	uint contains_data;
	git_diff_binary_file old_file;
	git_diff_binary_file new_file;
}

alias git_diff_binary_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_binary)* binary,
	void* payload);

struct git_diff_hunk {
	int    old_start;
	int    old_lines;
	int    new_start;
	int    new_lines;
	size_t header_len;
	char[GIT_DIFF_HUNK_HEADER_SIZE] header;
}

alias git_diff_hunk_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_hunk)* hunk,
	void* payload);

enum git_diff_line_t {
	GIT_DIFF_LINE_CONTEXT   = ' ',
	GIT_DIFF_LINE_ADDITION  = '+',
	GIT_DIFF_LINE_DELETION  = '-',
	GIT_DIFF_LINE_CONTEXT_EOFNL = '=',
	GIT_DIFF_LINE_ADD_EOFNL = '>',
	GIT_DIFF_LINE_DEL_EOFNL = '<',
	GIT_DIFF_LINE_FILE_HDR  = 'F',
	GIT_DIFF_LINE_HUNK_HDR  = 'H',
	GIT_DIFF_LINE_BINARY    = 'B'
}
mixin(MakeEnum!git_diff_line_t);

struct git_diff_line {
	char   origin;
	int    old_lineno;
	int    new_lineno;
	int    num_lines;
	size_t content_len;
	git_off_t content_offset;
	const(char)* content;
}

alias git_diff_line_cb = int function(
	const(git_diff_delta)* delta,
	const(git_diff_hunk)* hunk,
	const(git_diff_line)* line,
	void* payload);

enum git_diff_find_t {
	GIT_DIFF_FIND_BY_CONFIG = 0,
	GIT_DIFF_FIND_RENAMES = (1u << 0),
	GIT_DIFF_FIND_RENAMES_FROM_REWRITES = (1u << 1),
	GIT_DIFF_FIND_COPIES = (1u << 2),
	GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED = (1u << 3),
	GIT_DIFF_FIND_REWRITES = (1u << 4),
	GIT_DIFF_BREAK_REWRITES = (1u << 5),
	GIT_DIFF_FIND_AND_BREAK_REWRITES =
		(GIT_DIFF_FIND_REWRITES | GIT_DIFF_BREAK_REWRITES),
	GIT_DIFF_FIND_FOR_UNTRACKED = (1u << 6),
	GIT_DIFF_FIND_ALL = (0x0ff),
	GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE = 0,
	GIT_DIFF_FIND_IGNORE_WHITESPACE = (1u << 12),
	GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE = (1u << 13),
	GIT_DIFF_FIND_EXACT_MATCH_ONLY = (1u << 14),
	GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY  = (1u << 15),
	GIT_DIFF_FIND_REMOVE_UNMODIFIED = (1u << 16),
}
mixin(MakeEnum!git_diff_find_t);

struct git_diff_similarity_metric {
	int function(
		void** out_,
		const(git_diff_file)* file,
		const(char)* fullpath,
		void* payload) file_signature;
	int function(
		void** out_,
		const(git_diff_file)* file,
		const(char)* buf,
		size_t buflen,
		void* payload) buffer_signature;
	void function(void* sig, void* payload) free_signature;
	int function(int* score, void* siga, void* sigb, void* payload) similarity;
	void* payload;
}

struct git_diff_find_options {
	uint version_;
	uint flags;
	ushort rename_threshold;
	ushort rename_from_rewrite_threshold;
	ushort copy_threshold;
	ushort break_rewrite_threshold;
	size_t rename_limit;
	git_diff_similarity_metric* metric;
}

enum git_diff_format_t {
	GIT_DIFF_FORMAT_PATCH        = 1u,
	GIT_DIFF_FORMAT_PATCH_HEADER = 2u,
	GIT_DIFF_FORMAT_RAW          = 3u,
	GIT_DIFF_FORMAT_NAME_ONLY    = 4u,
	GIT_DIFF_FORMAT_NAME_STATUS  = 5u,
}
mixin(MakeEnum!git_diff_format_t);

struct git_diff_stats;

enum git_diff_stats_format_t {
	GIT_DIFF_STATS_NONE = 0,
	GIT_DIFF_STATS_FULL = (1u << 0),
	GIT_DIFF_STATS_SHORT = (1u << 1),
	GIT_DIFF_STATS_NUMBER = (1u << 2),
	GIT_DIFF_STATS_INCLUDE_SUMMARY = (1u << 3),
}
mixin(MakeEnum!git_diff_stats_format_t);

enum git_diff_format_email_flags_t {
	GIT_DIFF_FORMAT_EMAIL_NONE = 0,
	GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER = (1 << 0),
}
mixin(MakeEnum!git_diff_format_email_flags_t);

struct git_diff_format_email_options {
	uint version_;
	git_diff_format_email_flags_t flags;
	size_t patch_no;
	size_t total_patches;
	const(git_oid)* id;
	const(char)* summary;
	const(char)* body_;
	const(git_signature)* author;
}

enum GIT_DIFF_OPTIONS_VERSION = 1;
enum GIT_DIFF_FIND_OPTIONS_VERSION = 1;
enum GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION = 1;

// errors.h

enum git_error_code {
	GIT_OK         =  0,
	GIT_ERROR      = -1,
	GIT_ENOTFOUND  = -3,
	GIT_EEXISTS    = -4,
	GIT_EAMBIGUOUS = -5,
	GIT_EBUFS      = -6,
	GIT_EUSER      = -7,
	GIT_EBAREREPO       =  -8,
	GIT_EUNBORNBRANCH   =  -9,
	GIT_EUNMERGED       = -10,
	GIT_ENONFASTFORWARD = -11,
	GIT_EINVALIDSPEC    = -12,
	GIT_ECONFLICT       = -13,
	GIT_ELOCKED         = -14,
	GIT_EMODIFIED       = -15,
	GIT_EAUTH           = -16,
	GIT_ECERTIFICATE    = -17,
	GIT_EAPPLIED        = -18,
	GIT_EPEEL           = -19,
	GIT_EEOF            = -20,
	GIT_EINVALID        = -21,
	GIT_EUNCOMMITTED    = -22,
	GIT_EDIRECTORY      = -23,
	GIT_EMERGECONFLICT  = -24,
	GIT_PASSTHROUGH     = -30,
	GIT_ITEROVER        = -31,
}
mixin(MakeEnum!git_error_code);

struct git_error {
	char* message;
	int klass;
}

enum git_error_t {
	GITERR_NONE = 0,
	GITERR_NOMEMORY,
	GITERR_OS,
	GITERR_INVALID,
	GITERR_REFERENCE,
	GITERR_ZLIB,
	GITERR_REPOSITORY,
	GITERR_CONFIG,
	GITERR_REGEX,
	GITERR_ODB,
	GITERR_INDEX,
	GITERR_OBJECT,
	GITERR_NET,
	GITERR_TAG,
	GITERR_TREE,
	GITERR_INDEXER,
	GITERR_SSL,
	GITERR_SUBMODULE,
	GITERR_THREAD,
	GITERR_STASH,
	GITERR_CHECKOUT,
	GITERR_FETCHHEAD,
	GITERR_MERGE,
	GITERR_SSH,
	GITERR_FILTER,
	GITERR_REVERT,
	GITERR_CALLBACK,
	GITERR_CHERRYPICK,
	GITERR_DESCRIBE,
	GITERR_REBASE,
	GITERR_FILESYSTEM,
	GITERR_PATCH,
}
mixin(MakeEnum!git_error_t);

// filter.h

enum git_filter_mode_t {
	GIT_FILTER_TO_WORKTREE = 0,
	GIT_FILTER_SMUDGE = GIT_FILTER_TO_WORKTREE,
	GIT_FILTER_TO_ODB = 1,
	GIT_FILTER_CLEAN = GIT_FILTER_TO_ODB,
}
mixin(MakeEnum!git_filter_mode_t);

enum git_filter_flag_t {
	GIT_FILTER_DEFAULT = 0u,
	GIT_FILTER_ALLOW_UNSAFE = (1u << 0),
}
mixin(MakeEnum!git_filter_flag_t);

struct git_filter;

struct git_filter_list;

// index.h

struct git_index_time {
	int seconds;
	uint nanoseconds;
}

struct git_index_entry {
	git_index_time ctime;
	git_index_time mtime;
	uint dev;
	uint ino;
	uint mode;
	uint uid;
	uint gid;
	uint file_size;
	git_oid id;
	ushort flags;
	ushort flags_extended;
	const(char)* path;
}

enum GIT_IDXENTRY_NAMEMASK = (0x0fff);
enum GIT_IDXENTRY_STAGEMASK = (0x3000);
enum GIT_IDXENTRY_STAGESHIFT = 12;

enum git_indxentry_flag_t {
	GIT_IDXENTRY_EXTENDED  = (0x4000),
	GIT_IDXENTRY_VALID     = (0x8000),
}
mixin(MakeEnum!git_indxentry_flag_t);

enum git_idxentry_extended_flag_t {
	GIT_IDXENTRY_INTENT_TO_ADD  =  (1 << 13),
	GIT_IDXENTRY_SKIP_WORKTREE  =  (1 << 14),
	GIT_IDXENTRY_EXTENDED2      =  (1 << 15),
	GIT_IDXENTRY_EXTENDED_FLAGS = (GIT_IDXENTRY_INTENT_TO_ADD | GIT_IDXENTRY_SKIP_WORKTREE),
	GIT_IDXENTRY_UPDATE            =  (1 << 0),
	GIT_IDXENTRY_REMOVE            =  (1 << 1),
	GIT_IDXENTRY_UPTODATE          =  (1 << 2),
	GIT_IDXENTRY_ADDED             =  (1 << 3),
	GIT_IDXENTRY_HASHED            =  (1 << 4),
	GIT_IDXENTRY_UNHASHED          =  (1 << 5),
	GIT_IDXENTRY_WT_REMOVE         =  (1 << 6),
	GIT_IDXENTRY_CONFLICTED        =  (1 << 7),
	GIT_IDXENTRY_UNPACKED          =  (1 << 8),
	GIT_IDXENTRY_NEW_SKIP_WORKTREE =  (1 << 9),
}
mixin(MakeEnum!git_idxentry_extended_flag_t);

enum git_indexcap_t {
	GIT_INDEXCAP_IGNORE_CASE = 1,
	GIT_INDEXCAP_NO_FILEMODE = 2,
	GIT_INDEXCAP_NO_SYMLINKS = 4,
	GIT_INDEXCAP_FROM_OWNER  = -1,
}
mixin(MakeEnum!git_indexcap_t);

alias git_index_matched_path_cb = int function(
	const(char)*path,
	const(char)* matched_pathspec,
	void* payload);

enum git_index_add_option_t {
	GIT_INDEX_ADD_DEFAULT = 0,
	GIT_INDEX_ADD_FORCE = (1u << 0),
	GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH = (1u << 1),
	GIT_INDEX_ADD_CHECK_PATHSPEC = (1u << 2),
}
mixin(MakeEnum!git_index_add_option_t);

enum git_index_stage_t {
	GIT_INDEX_STAGE_ANY = -1,
	GIT_INDEX_STAGE_NORMAL = 0,
	GIT_INDEX_STAGE_ANCESTOR = 1,
	GIT_INDEX_STAGE_OURS = 2,
	GIT_INDEX_STAGE_THEIRS = 3,
}
mixin(MakeEnum!git_index_stage_t);

// indexer.h

struct git_indexer;

// merge.h

enum GIT_MERGE_FILE_INPUT_VERSION = 1;
enum GIT_MERGE_FILE_OPTIONS_VERSION = 1;
enum GIT_MERGE_OPTIONS_VERSION = 1;

struct git_merge_file_input {
	uint version_;
	const(char)* ptr;
	size_t size;
	const(char)* path;
	uint mode;
}

enum git_merge_flag_t {
	GIT_MERGE_FIND_RENAMES = (1 << 0),
	GIT_MERGE_FAIL_ON_CONFLICT = (1 << 1),
	GIT_MERGE_SKIP_REUC = (1 << 2),
	GIT_MERGE_NO_RECURSIVE = (1 << 3),
}
mixin(MakeEnum!git_merge_flag_t);

enum git_merge_file_favor_t {
	GIT_MERGE_FILE_FAVOR_NORMAL = 0,
	GIT_MERGE_FILE_FAVOR_OURS = 1,
	GIT_MERGE_FILE_FAVOR_THEIRS = 2,
	GIT_MERGE_FILE_FAVOR_UNION = 3,
}
mixin(MakeEnum!git_merge_file_favor_t);

enum git_merge_file_flag_t {
	GIT_MERGE_FILE_DEFAULT = 0,
	GIT_MERGE_FILE_STYLE_MERGE = (1 << 0),
	GIT_MERGE_FILE_STYLE_DIFF3 = (1 << 1),
	GIT_MERGE_FILE_SIMPLIFY_ALNUM = (1 << 2),
	GIT_MERGE_FILE_IGNORE_WHITESPACE = (1 << 3),
	GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE = (1 << 4),
	GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL = (1 << 5),
	GIT_MERGE_FILE_DIFF_PATIENCE = (1 << 6),
	GIT_MERGE_FILE_DIFF_MINIMAL = (1 << 7),
}
mixin(MakeEnum!git_merge_file_flag_t);

struct git_merge_file_options {
	uint version_;
	const(char)* ancestor_label;
	const(char)* our_label;
	const(char)* their_label;
	git_merge_file_favor_t favor;
	git_merge_file_flag_t flags;
}

struct git_merge_file_result {
	uint automergeable;
	const(char)* path;
	uint mode;
	const(char)* ptr;
	size_t len;
}

struct git_merge_options {
	uint version_;
	git_merge_flag_t flags;
	uint rename_threshold;
	uint target_limit;
	git_diff_similarity_metric *metric;
	uint recursion_limit;
	const(char)* default_driver;
	git_merge_file_favor_t file_favor;
	git_merge_file_flag_t file_flags;
}

enum git_merge_analysis_t {
	GIT_MERGE_ANALYSIS_NONE = 0,
	GIT_MERGE_ANALYSIS_NORMAL = (1 << 0),
	GIT_MERGE_ANALYSIS_UP_TO_DATE = (1 << 1),
	GIT_MERGE_ANALYSIS_FASTFORWARD = (1 << 2),
	GIT_MERGE_ANALYSIS_UNBORN = (1 << 3),
}
mixin(MakeEnum!git_merge_analysis_t);

enum git_merge_preference_t {
	GIT_MERGE_PREFERENCE_NONE = 0,
	GIT_MERGE_PREFERENCE_NO_FASTFORWARD = (1 << 0),
	GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY = (1 << 1),
}
mixin(MakeEnum!git_merge_preference_t);

// net.h
enum GIT_DEFAULT_PORT = 9418;
enum git_direction {
	GIT_DIRECTION_FETCH = 0,
	GIT_DIRECTION_PUSH  = 1
}
mixin(MakeEnum!git_direction);

struct git_remote_head {
	int local;
	git_oid oid;
	git_oid loid;
	char* name;
	char* symref_target;
}

alias git_headlist_cb = int function(git_remote_head* rhead, void* payload);

// notes.h

alias git_note_foreach_cb = int function(
	const(git_oid)* blob_id,
	const(git_oid)* annotated_object_id,
	void* payload);

struct git_note_iterator;

// odb.h

alias git_odb_foreach_cb = int function(const(git_oid)* id, void* payload);

struct git_odb_expand_id {
	git_oid id;
	ushort length;
	git_otype type;
}

// odb_backend.h

enum git_odb_stream_t {
	GIT_STREAM_RDONLY = (1 << 1),
	GIT_STREAM_WRONLY = (1 << 2),
	GIT_STREAM_RW = (GIT_STREAM_RDONLY | GIT_STREAM_WRONLY),
}
mixin(MakeEnum!git_odb_stream_t);

struct git_odb_stream {
	git_odb_backend* backend;
	uint mode;
	void* hash_ctx;
	git_off_t declared_size;
	git_off_t received_bytes;
	int function(git_odb_stream* stream, char* buffer, size_t len) read;
	int function(git_odb_stream* stream, const(char)* buffer, size_t len) write;
	int function(git_odb_stream* stream, const(git_oid)* oid) finalize_write;
	void function(git_odb_stream* stream) free;
}

// oid.h

enum GIT_OID_RAWSZ = 20;
enum GIT_OID_HEXSZ = (GIT_OID_RAWSZ * 2);
enum GIT_OID_MINPREFIXLEN = 4;

struct git_oid {
	ubyte[GIT_OID_RAWSZ] id;
}

struct git_oid_shorten;

// oidarray.h

struct git_oidarray {
	git_oid* ids;
	size_t count;
}

// pack.h

enum git_packbuilder_stage_t {
	GIT_PACKBUILDER_ADDING_OBJECTS = 0,
	GIT_PACKBUILDER_DELTAFICATION = 1,
}
mixin(MakeEnum!git_packbuilder_stage_t);

alias git_packbuilder_foreach_cb = int function(void* buf, size_t size, void* payload);

alias git_packbuilder_progress = int function(
	int stage,
	uint current,
	uint total,
	void* payload);


// patch.h

struct git_patch;

// pathspec.h

struct git_pathspec;

struct git_pathspec_match_list;

enum git_pathspec_flag_t {
	GIT_PATHSPEC_DEFAULT        = 0,
	GIT_PATHSPEC_IGNORE_CASE    = (1u << 0),
	GIT_PATHSPEC_USE_CASE       = (1u << 1),
	GIT_PATHSPEC_NO_GLOB        = (1u << 2),
	GIT_PATHSPEC_NO_MATCH_ERROR = (1u << 3),
	GIT_PATHSPEC_FIND_FAILURES  = (1u << 4),
	GIT_PATHSPEC_FAILURES_ONLY  = (1u << 5),
}
mixin(MakeEnum!git_pathspec_flag_t);

// proxy.h

enum git_proxy_t {
	GIT_PROXY_NONE,
	GIT_PROXY_AUTO,
	GIT_PROXY_SPECIFIED,
}
mixin(MakeEnum!git_proxy_t);

struct git_proxy_options {
	uint version_;
	git_proxy_t type;
	const(char)* url;
	git_cred_acquire_cb credentials;
	git_transport_certificate_check_cb certificate_check;
	void* payload;
}

enum GIT_PROXY_OPTIONS_VERSION = 1;

// rebase.h

struct git_rebase_options {
	uint version_;
	int quiet;
	int inmemory;
	const(char)* rewrite_notes_ref;
	git_merge_options merge_options;
	git_checkout_options checkout_options;
}

enum git_rebase_operation_t {
	GIT_REBASE_OPERATION_PICK = 0,
	GIT_REBASE_OPERATION_REWORD,
	GIT_REBASE_OPERATION_EDIT,
	GIT_REBASE_OPERATION_SQUASH,
	GIT_REBASE_OPERATION_FIXUP,
	GIT_REBASE_OPERATION_EXEC,
}
mixin(MakeEnum!git_rebase_operation_t);

struct git_rebase_operation {
	git_rebase_operation_t type;
	const(git_oid) id;
	const(char)* exec;
}

enum GIT_REBASE_OPTIONS_VERSION = 1;
enum GIT_REBASE_NO_OPERATION = size_t.max;

// refs.h

alias git_reference_foreach_cb = int function(git_reference* reference, void* payload);
alias git_reference_foreach_name_cb = int function(const(char)* name, void* payload);

enum git_reference_normalize_t {
	GIT_REF_FORMAT_NORMAL = 0u,
	GIT_REF_FORMAT_ALLOW_ONELEVEL = (1u << 0),
	GIT_REF_FORMAT_REFSPEC_PATTERN = (1u << 1),
	GIT_REF_FORMAT_REFSPEC_SHORTHAND = (1u << 2),
}
mixin(MakeEnum!git_reference_normalize_t);

// remote.h

enum git_remote_completion_type {
	GIT_REMOTE_COMPLETION_DOWNLOAD,
	GIT_REMOTE_COMPLETION_INDEXING,
	GIT_REMOTE_COMPLETION_ERROR,
}
mixin(MakeEnum!git_remote_completion_type);

alias git_push_transfer_progress = int function(
	uint current,
	uint total,
	size_t bytes,
	void* payload);

struct git_push_update {
	char *src_refname;
	char *dst_refname;
	git_oid src;
	git_oid dst;
}

alias git_push_negotiation = int function(
	const(git_push_update)** updates,
	size_t len,
	void* payload);

struct git_remote_callbacks {
	uint version_;
	git_transport_message_cb sideband_progress;
	int function(git_remote_completion_type type, void* data) completion;
	git_cred_acquire_cb credentials;
	git_transport_certificate_check_cb certificate_check;
	git_transfer_progress_cb transfer_progress;
	int function(
		const(char)* refname,
		const(git_oid)* a,
		const(git_oid)* b,
		void* data) update_tips;
	git_packbuilder_progress pack_progress;
	git_push_transfer_progress push_transfer_progress;
	int function(
		const(char)* refname,
		const(char)* status,
		void* data) push_update_reference;
	git_push_negotiation push_negotiation;
	git_transport_cb transport;
	void* payload;
}


enum git_fetch_prune_t {
	GIT_FETCH_PRUNE_UNSPECIFIED,
	GIT_FETCH_PRUNE,
	GIT_FETCH_NO_PRUNE,
}
mixin(MakeEnum!git_fetch_prune_t);

enum git_remote_autotag_option_t {
	GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED = 0,
	GIT_REMOTE_DOWNLOAD_TAGS_AUTO,
	GIT_REMOTE_DOWNLOAD_TAGS_NONE,
	GIT_REMOTE_DOWNLOAD_TAGS_ALL,
}
mixin(MakeEnum!git_remote_autotag_option_t);

struct git_fetch_options {
	int version_;
	git_remote_callbacks callbacks;
	git_fetch_prune_t prune;
	int update_fetchhead;
	git_remote_autotag_option_t download_tags;
	git_proxy_options proxy_opts;
	git_strarray custom_headers;
}

struct git_push_options {
	uint version_;
	uint pb_parallelism;
	git_remote_callbacks callbacks;
	git_proxy_options proxy_opts;
	git_strarray custom_headers;
}

enum GIT_REMOTE_CALLBACKS_VERSION = 1;
enum GIT_PUSH_OPTIONS_VERSION = 1;
enum GIT_FETCH_OPTIONS_VERSION = 1;

// repository.h

enum git_repository_open_flag_t {
	GIT_REPOSITORY_OPEN_NO_SEARCH = (1 << 0),
	GIT_REPOSITORY_OPEN_CROSS_FS  = (1 << 1),
	GIT_REPOSITORY_OPEN_BARE      = (1 << 2),
	GIT_REPOSITORY_OPEN_NO_DOTGIT = (1 << 3),
	GIT_REPOSITORY_OPEN_FROM_ENV  = (1 << 4),
}
mixin(MakeEnum!git_repository_open_flag_t);

enum git_repository_init_flag_t {
	GIT_REPOSITORY_INIT_BARE              = (1u << 0),
	GIT_REPOSITORY_INIT_NO_REINIT         = (1u << 1),
	GIT_REPOSITORY_INIT_NO_DOTGIT_DIR     = (1u << 2),
	GIT_REPOSITORY_INIT_MKDIR             = (1u << 3),
	GIT_REPOSITORY_INIT_MKPATH            = (1u << 4),
	GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE = (1u << 5),
	GIT_REPOSITORY_INIT_RELATIVE_GITLINK  = (1u << 6),
}
mixin(MakeEnum!git_repository_init_flag_t);

enum git_repository_init_mode_t {
	GIT_REPOSITORY_INIT_SHARED_UMASK = 0,
	GIT_REPOSITORY_INIT_SHARED_GROUP = octal!2775,
	GIT_REPOSITORY_INIT_SHARED_ALL   = octal!2777,
}
mixin(MakeEnum!git_repository_init_mode_t);

struct git_repository_init_options{
	uint version_;
	uint    flags;
	uint    mode;
	const(char)* workdir_path;
	const(char)* description;
	const(char)* template_path;
	const(char)* initial_head;
	const(char)* origin_url;
}

alias git_repository_fetchhead_foreach_cb = int function(
	const(char)* ref_name,
	const(char)* remote_url,
	const(git_oid)* oid,
	uint is_merge,
	void* payload);


alias git_repository_mergehead_foreach_cb = int function(
	const(git_oid)* oid,
	void* payload);

enum git_repository_state_t {
	GIT_REPOSITORY_STATE_NONE,
	GIT_REPOSITORY_STATE_MERGE,
	GIT_REPOSITORY_STATE_REVERT,
	GIT_REPOSITORY_STATE_REVERT_SEQUENCE,
	GIT_REPOSITORY_STATE_CHERRYPICK,
	GIT_REPOSITORY_STATE_CHERRYPICK_SEQUENCE,
	GIT_REPOSITORY_STATE_BISECT,
	GIT_REPOSITORY_STATE_REBASE,
	GIT_REPOSITORY_STATE_REBASE_INTERACTIVE,
	GIT_REPOSITORY_STATE_REBASE_MERGE,
	GIT_REPOSITORY_STATE_APPLY_MAILBOX,
	GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE,
}
mixin(MakeEnum!git_repository_state_t);

enum GIT_REPOSITORY_INIT_OPTIONS_VERSION = 1;

// reset.h

enum git_reset_t {
	GIT_RESET_SOFT  = 1,
	GIT_RESET_MIXED = 2,
	GIT_RESET_HARD  = 3,
}
mixin(MakeEnum!git_reset_t);

// revert.h

struct git_revert_options {
	uint version_;
	uint mainline;
	git_merge_options merge_opts;
	git_checkout_options checkout_opts;
}

enum GIT_REVERT_OPTIONS_VERSION = 1;

// revparse.h

enum git_revparse_mode_t {
	GIT_REVPARSE_SINGLE         = 1 << 0,
	GIT_REVPARSE_RANGE          = 1 << 1,
	GIT_REVPARSE_MERGE_BASE     = 1 << 2,
}
mixin(MakeEnum!git_revparse_mode_t);

struct git_revspec {
	git_object* from;
	git_object* to;
	uint flags;
}

// revwalk.h

enum git_sort_t {
	GIT_SORT_NONE = 0,
	GIT_SORT_TOPOLOGICAL = 1 << 0,
	GIT_SORT_TIME = 1 << 1,
	GIT_SORT_REVERSE = 1 << 2,
}
mixin(MakeEnum!git_sort_t);

alias git_revwalk_hide_cb = int function(
	const(git_oid)* commit_id,
	void* payload);

// stash.h

enum git_stash_flags {
	GIT_STASH_DEFAULT = 0,
	GIT_STASH_KEEP_INDEX = (1 << 0),
	GIT_STASH_INCLUDE_UNTRACKED = (1 << 1),
	GIT_STASH_INCLUDE_IGNORED = (1 << 2),
}
mixin(MakeEnum!git_stash_flags);

enum git_stash_apply_flags {
	GIT_STASH_APPLY_DEFAULT = 0,
	GIT_STASH_APPLY_REINSTATE_INDEX = (1 << 0),
}
mixin(MakeEnum!git_stash_apply_flags);

enum git_stash_apply_progress_t {
	GIT_STASH_APPLY_PROGRESS_NONE = 0,
	GIT_STASH_APPLY_PROGRESS_LOADING_STASH,
	GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX,
	GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED,
	GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED,
	GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED,
	GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED,
	GIT_STASH_APPLY_PROGRESS_DONE,
}
mixin(MakeEnum!git_stash_apply_progress_t);

alias git_stash_apply_progress_cb = int function(
	git_stash_apply_progress_t progress,
	void* payload);

struct git_stash_apply_options {
	uint version_;
	git_stash_apply_flags flags;
	git_checkout_options checkout_options;
	git_stash_apply_progress_cb progress_cb;
	void* progress_payload;
}

alias git_stash_cb = int function(
	size_t index,
	const(char)* message,
	const(git_oid)* stash_id,
	void* payload);

enum GIT_STASH_APPLY_OPTIONS_VERSION = 1;

// status.h

enum git_status_t {
	GIT_STATUS_CURRENT = 0,
	GIT_STATUS_INDEX_NEW        = (1u << 0),
	GIT_STATUS_INDEX_MODIFIED   = (1u << 1),
	GIT_STATUS_INDEX_DELETED    = (1u << 2),
	GIT_STATUS_INDEX_RENAMED    = (1u << 3),
	GIT_STATUS_INDEX_TYPECHANGE = (1u << 4),
	GIT_STATUS_WT_NEW           = (1u << 7),
	GIT_STATUS_WT_MODIFIED      = (1u << 8),
	GIT_STATUS_WT_DELETED       = (1u << 9),
	GIT_STATUS_WT_TYPECHANGE    = (1u << 10),
	GIT_STATUS_WT_RENAMED       = (1u << 11),
	GIT_STATUS_WT_UNREADABLE    = (1u << 12),
	GIT_STATUS_IGNORED          = (1u << 14),
	GIT_STATUS_CONFLICTED       = (1u << 15),
}
mixin(MakeEnum!git_status_t);

alias git_status_cb = int function(
	const(char)* path,
	uint status_flags,
	void* payload);

enum git_status_show_t {
	GIT_STATUS_SHOW_INDEX_AND_WORKDIR = 0,
	GIT_STATUS_SHOW_INDEX_ONLY = 1,
	GIT_STATUS_SHOW_WORKDIR_ONLY = 2,
}
mixin(MakeEnum!git_status_show_t);

enum git_status_opt_t {
	GIT_STATUS_OPT_INCLUDE_UNTRACKED                = (1u << 0),
	GIT_STATUS_OPT_INCLUDE_IGNORED                  = (1u << 1),
	GIT_STATUS_OPT_INCLUDE_UNMODIFIED               = (1u << 2),
	GIT_STATUS_OPT_EXCLUDE_SUBMODULES               = (1u << 3),
	GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS           = (1u << 4),
	GIT_STATUS_OPT_DISABLE_PATHSPEC_MATCH           = (1u << 5),
	GIT_STATUS_OPT_RECURSE_IGNORED_DIRS             = (1u << 6),
	GIT_STATUS_OPT_RENAMES_HEAD_TO_INDEX            = (1u << 7),
	GIT_STATUS_OPT_RENAMES_INDEX_TO_WORKDIR         = (1u << 8),
	GIT_STATUS_OPT_SORT_CASE_SENSITIVELY            = (1u << 9),
	GIT_STATUS_OPT_SORT_CASE_INSENSITIVELY          = (1u << 10),
	GIT_STATUS_OPT_RENAMES_FROM_REWRITES            = (1u << 11),
	GIT_STATUS_OPT_NO_REFRESH                       = (1u << 12),
	GIT_STATUS_OPT_UPDATE_INDEX                     = (1u << 13),
	GIT_STATUS_OPT_INCLUDE_UNREADABLE               = (1u << 14),
	GIT_STATUS_OPT_INCLUDE_UNREADABLE_AS_UNTRACKED  = (1u << 15),
}
mixin(MakeEnum!git_status_opt_t);

struct git_status_options {
	uint version_;
	git_status_show_t show;
	uint flags;
	git_strarray pathspec;
}

struct git_status_entry {
	git_status_t status;
	git_diff_delta* head_to_index;
	git_diff_delta* index_to_workdir;
}

enum GIT_STATUS_OPTIONS_VERSION = 1;

// strarray.h

struct git_strarray {
	char** strings;
	size_t count;
}

// submodule.h

enum git_submodule_status_t {
	GIT_SUBMODULE_STATUS_IN_HEAD           = (1u << 0),
	GIT_SUBMODULE_STATUS_IN_INDEX          = (1u << 1),
	GIT_SUBMODULE_STATUS_IN_CONFIG         = (1u << 2),
	GIT_SUBMODULE_STATUS_IN_WD             = (1u << 3),
	GIT_SUBMODULE_STATUS_INDEX_ADDED       = (1u << 4),
	GIT_SUBMODULE_STATUS_INDEX_DELETED     = (1u << 5),
	GIT_SUBMODULE_STATUS_INDEX_MODIFIED    = (1u << 6),
	GIT_SUBMODULE_STATUS_WD_UNINITIALIZED  = (1u << 7),
	GIT_SUBMODULE_STATUS_WD_ADDED          = (1u << 8),
	GIT_SUBMODULE_STATUS_WD_DELETED        = (1u << 9),
	GIT_SUBMODULE_STATUS_WD_MODIFIED       = (1u << 10),
	GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED = (1u << 11),
	GIT_SUBMODULE_STATUS_WD_WD_MODIFIED    = (1u << 12),
	GIT_SUBMODULE_STATUS_WD_UNTRACKED      = (1u << 13),
}
mixin(MakeEnum!git_submodule_status_t);

enum GIT_SUBMODULE_STATUS__IN_FLAGS = 0x000Fu;
enum GIT_SUBMODULE_STATUS__INDEX_FLAGS = 0x0070u;
enum GIT_SUBMODULE_STATUS__WD_FLAGS = 0x3F80u;

enum GIT_SUBMODULE_UPDATE_OPTIONS_VERSION = 1;

alias git_submodule_cb = int function(
	git_submodule* sm,
	const(char)* name,
	void* payload);

struct git_submodule_update_options {
	uint version_;
	git_checkout_options checkout_opts;
	git_fetch_options fetch_opts;
	uint clone_checkout_strategy;
	int allow_fetch;
}

// tag.h

alias git_tag_foreach_cb = int function(
	const(char)* name,
	git_oid* oid,
	void* payload);

// trace.h

enum git_trace_level_t {
	GIT_TRACE_NONE = 0,
	GIT_TRACE_FATAL = 1,
	GIT_TRACE_ERROR = 2,
	GIT_TRACE_WARN = 3,
	GIT_TRACE_INFO = 4,
	GIT_TRACE_DEBUG = 5,
	GIT_TRACE_TRACE = 6
}
mixin(MakeEnum!git_trace_level_t);

alias git_trace_callback = void function(
	git_trace_level_t level,
	const(char)* msg);

// transport.h

alias git_transport_cb = int function(
	git_transport** out_,
	git_remote* owner,
	void* param);

enum git_cert_ssh_t {
	GIT_CERT_SSH_MD5 = (1 << 0),
	GIT_CERT_SSH_SHA1 = (1 << 1),
}
mixin(MakeEnum!git_cert_ssh_t);

struct git_cert_hostkey {
	git_cert parent;
	git_cert_ssh_t type;
	ubyte[16] hash_md5;
	ubyte[20] hash_sha1;
}

struct git_cert_x509 {
	git_cert parent;
	void* data;
	size_t len;
}

enum git_credtype_t {
	GIT_CREDTYPE_USERPASS_PLAINTEXT = (1u << 0),
	GIT_CREDTYPE_SSH_KEY = (1u << 1),
	GIT_CREDTYPE_SSH_CUSTOM = (1u << 2),
	GIT_CREDTYPE_DEFAULT = (1u << 3),
	GIT_CREDTYPE_SSH_INTERACTIVE = (1u << 4),
	GIT_CREDTYPE_USERNAME = (1u << 5),
	GIT_CREDTYPE_SSH_MEMORY = (1u << 6),
}
mixin(MakeEnum!git_credtype_t);

struct git_cred {
	git_credtype_t credtype;
	void function(git_cred* cred) free;
}

struct git_cred_userpass_plaintext {
	git_cred parent;
	char* username;
	char* password;
}

version(all) { // todo
	struct LIBSSH2_SESSION;
	struct LIBSSH2_USERAUTH_KBDINT_PROMPT;
	struct LIBSSH2_USERAUTH_KBDINT_RESPONSE;
}
alias git_cred_sign_callback = int function(
	LIBSSH2_SESSION* session,
	ubyte** sig,
	size_t* sig_len,
	const(ubyte)* data,
	size_t data_len,
	void** abstract_);
alias git_cred_ssh_interactive_callback = void function(
	const(char)* name,
	int name_len,
	const(char)* instruction,
	int instruction_len,
	int num_prompts,
	const(LIBSSH2_USERAUTH_KBDINT_PROMPT)* prompts,
	LIBSSH2_USERAUTH_KBDINT_RESPONSE* responses,
	void** abstract_);

struct git_cred_ssh_key {
	git_cred parent;
	char* username;
	char* publickey;
	char* privatekey;
	char* passphrase;
}

struct git_cred_ssh_interactive {
	git_cred parent;
	char* username;
	git_cred_ssh_interactive_callback prompt_callback;
	void* payload;
}

struct git_cred_ssh_custom {
	git_cred parent;
	char* username;
	char* publickey;
	size_t publickey_len;
	git_cred_sign_callback sign_callback;
	void* payload;
}

struct git_cred_username {
	git_cred parent;
	char[1] username;
}

alias git_cred_acquire_cb = int function(
	git_cred** cred,
	const(char)* url,
	const(char)* username_from_url,
	uint allowed_types,
	void* payload);

// tree.h

alias git_treebuilder_filter_cb = int function(const(git_tree_entry)* entry, void* payload);

alias git_treewalk_cb = int function(
	const(char)* root,
	const(git_tree_entry)* entry,
	void* payload);

enum git_treewalk_mode {
	GIT_TREEWALK_PRE = 0, /* Pre-order */
	GIT_TREEWALK_POST = 1, /* Post-order */
}
mixin(MakeEnum!git_treewalk_mode);

enum git_tree_update_t {
	GIT_TREE_UPDATE_UPSERT,
	GIT_TREE_UPDATE_REMOVE,
}
mixin(MakeEnum!git_tree_update_t);

struct git_tree_update {
	git_tree_update_t action;
	git_oid id;
	git_filemode_t filemode;
	const(char)* path;
}

// types.h

alias git_off_t = ulong;
alias git_time_t = ulong;


enum git_otype {
	GIT_OBJ_ANY = -2,
	GIT_OBJ_BAD = -1,
	GIT_OBJ__EXT1 = 0,
	GIT_OBJ_COMMIT = 1,
	GIT_OBJ_TREE = 2,
	GIT_OBJ_BLOB = 3,
	GIT_OBJ_TAG = 4,
	GIT_OBJ__EXT2 = 5,
	GIT_OBJ_OFS_DELTA = 6,
	GIT_OBJ_REF_DELTA = 7,
}
mixin(MakeEnum!git_otype);

struct git_odb;
struct git_odb_backend;
struct git_odb_object;
struct git_odb_writepack;
struct git_refdb;
struct git_refdb_backend;
struct git_repository;
struct git_object;
struct git_revwalk;
struct git_tag;
struct git_blob;
struct git_commit;
struct git_tree_entry;
struct git_tree;
struct git_treebuilder;
struct git_index;
struct git_index_conflict_iterator;
struct git_config;
struct git_config_backend;
struct git_reflog;
struct git_reflog_entry;
struct git_note;
struct git_packbuilder;

struct git_time {
	git_time_t time;
	int offset;
}

struct git_signature {
	char* name;
	char* email;
	git_time when;
}

struct git_reference;
struct git_reference_iterator;
struct git_transaction;
struct git_annotated_commit;
struct git_merge_result;
struct git_status_list;
struct git_rebase;

enum git_ref_t {
	GIT_REF_INVALID = 0,
	GIT_REF_OID = 1,
	GIT_REF_SYMBOLIC = 2,
	GIT_REF_LISTALL = GIT_REF_OID|GIT_REF_SYMBOLIC,
}
mixin(MakeEnum!git_ref_t);

enum git_branch_t {
	GIT_BRANCH_LOCAL = 1,
	GIT_BRANCH_REMOTE = 2,
	GIT_BRANCH_ALL = GIT_BRANCH_LOCAL|GIT_BRANCH_REMOTE,
}
mixin(MakeEnum!git_branch_t);

enum git_filemode_t {
	GIT_FILEMODE_UNREADABLE          = octal!0,
	GIT_FILEMODE_TREE                = octal!40000,
	GIT_FILEMODE_BLOB                = octal!100644,
	GIT_FILEMODE_BLOB_EXECUTABLE     = octal!100755,
	GIT_FILEMODE_LINK                = octal!120000,
	GIT_FILEMODE_COMMIT              = octal!160000,
}

struct git_refspec;
struct git_remote;
struct git_transport;
struct git_push;

struct git_transfer_progress {
	uint total_objects;
	uint indexed_objects;
	uint received_objects;
	uint local_objects;
	uint total_deltas;
	uint indexed_deltas;
	size_t received_bytes;
}

alias git_transfer_progress_cb = int function(
	const(git_transfer_progress)* stats,
	void* payload);


alias git_transport_message_cb = int function(
	const(char)* str,
	int len,
	void* payload);

enum git_cert_t {
	GIT_CERT_NONE,
	GIT_CERT_X509,
	GIT_CERT_HOSTKEY_LIBSSH2,
	GIT_CERT_STRARRAY,
}
mixin(MakeEnum!git_cert_t);

struct git_cert {
	git_cert_t cert_type;
}

alias git_transport_certificate_check_cb = int function(
	git_cert* cert,
	int valid,
	const(char)* host,
	void* payload);

struct git_submodule;

enum git_submodule_update_t {
	GIT_SUBMODULE_UPDATE_CHECKOUT = 1,
	GIT_SUBMODULE_UPDATE_REBASE   = 2,
	GIT_SUBMODULE_UPDATE_MERGE    = 3,
	GIT_SUBMODULE_UPDATE_NONE     = 4,
	GIT_SUBMODULE_UPDATE_DEFAULT  = 0
}
mixin(MakeEnum!git_submodule_update_t);

enum git_submodule_ignore_t {
	GIT_SUBMODULE_IGNORE_UNSPECIFIED  = -1,
	GIT_SUBMODULE_IGNORE_NONE      = 1,
	GIT_SUBMODULE_IGNORE_UNTRACKED = 2,
	GIT_SUBMODULE_IGNORE_DIRTY     = 3,
	GIT_SUBMODULE_IGNORE_ALL       = 4,
}
mixin(MakeEnum!git_submodule_ignore_t);

enum git_submodule_recurse_t {
	GIT_SUBMODULE_RECURSE_NO = 0,
	GIT_SUBMODULE_RECURSE_YES = 1,
	GIT_SUBMODULE_RECURSE_ONDEMAND = 2,
}
mixin(MakeEnum!git_submodule_recurse_t);

struct git_writestream {
	int function(git_writestream* stream, const(char)* buffer, size_t len) write;
	int function(git_writestream* stream) close;
	void function(git_writestream* stream) free;
}

// version.h

enum LIBGIT2_VERSION = "0.25.1";
enum LIBGIT2_VER_MAJOR = 0;
enum LIBGIT2_VER_MINOR = 25;
enum LIBGIT2_VER_REVISION = 1;
enum LIBGIT2_VER_PATCH = 0;

enum LIBGIT2_SOVERSION = 25;
