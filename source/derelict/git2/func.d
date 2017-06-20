module derelict.git2.func;

import derelict.util.loader;
import derelict.util.system;
import derelict.git2.type;

@system @nogc nothrow {
	// attr.h
	auto GIT_ATTR_TRUE(T)(T attr) {
		return git_attr_value(attr) == GIT_ATTR_TRUE_T;
	}
	auto GIT_ATTR_FALSE(T)(T attr) {
		return git_attr_value(attr) == GIT_ATTR_FALSE_T;
	}
	auto GIT_ATTR_UNSPECIFIED(T)(T attr) {
		return git_attr_value(attr) == GIT_ATTR_UNSPECIFIED_T;
	}
	auto GIT_ATTR_HAS_VALUE(T)(T attr) {
		return git_attr_value(attr) == GIT_ATTR_VALUE_T;
	}
}

// submodule.h
@safe pure @nogc nothrow GIT_SUBMODULE_STATUS_IS_UNMODIFIED(T)(T S) {
	return ((S) & ~GIT_SUBMODULE_STATUS__IN_FLAGS) == 0;
}
@safe pure @nogc nothrow GIT_SUBMODULE_STATUS_IS_INDEX_UNMODIFIED(T)(T S) {
	return ((S) & GIT_SUBMODULE_STATUS__INDEX_FLAGS) == 0;
}
@safe pure @nogc nothrow GIT_SUBMODULE_STATUS_IS_WD_UNMODIFIED(T)(T S) {
	return ((S) & (GIT_SUBMODULE_STATUS__WD_FLAGS &
		~GIT_SUBMODULE_STATUS_WD_UNINITIALIZED)) == 0;
}
@safe pure @nogc nothrow GIT_SUBMODULE_STATUS_IS_WD_DIRTY(T)(T S) {
	return ((S) & (GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED |
		GIT_SUBMODULE_STATUS_WD_WD_MODIFIED |
		GIT_SUBMODULE_STATUS_WD_UNTRACKED)) != 0;
}

extern(C) @system @nogc nothrow {
	// annotated_commit.h
	alias da_git_annotated_commit_from_ref = int function(git_annotated_commit**, git_repository*,const(git_reference)*);
	alias da_git_annotated_commit_from_fetchhead = int function(git_annotated_commit**,git_repository*,const(char)*,const(char)*,const(git_oid)*);
	alias da_git_annotated_commit_lookup = int function(git_annotated_commit**,git_repository*,const(git_oid)*);
	alias da_git_annotated_commit_from_revspec = int function(git_annotated_commit**,git_repository*,const(char)*);
	alias da_git_annotated_commit_id = const(git_oid)* function(const(git_annotated_commit)*);
	// attr.h
	alias da_git_attr_value = git_attr_t function(const(char)*);
	alias da_git_attr_get = int function(const(char)**,git_repository*,uint,const(char)*,const(char)*);
	alias da_git_attr_get_many = int function(const(char)**,git_repository*,uint,const(char)*,size_t,const(char)**);
	alias da_git_attr_foreach = int function(git_repository*,uint,const(char)*,git_attr_foreach_cb,void*);
	alias da_git_attr_cache_flush = void function(git_repository*);
	alias da_git_attr_add_macro = int function(git_repository*,const(char)*,const(char)*);
	// blame.h
	alias da_git_blame_init_options = int function(git_blame_options*,uint);
	alias da_git_blame_get_hunk_byindex = const(git_blame_hunk)* function(git_blame*,uint);
	alias da_git_blame_get_hunk_byline = const(git_blame_hunk)* function(git_blame*,size_t);
	alias da_git_blame_file = int function(git_blame**,git_repository*,const(char)*,git_blame_options*);
	alias da_git_blame_buffer = int function(git_blame**,git_blame*,const(char)*,size_t);
	alias da_git_blame_free = void function(git_blame*);
	// blob.h
	alias da_git_blob_lookup = int function(git_blob**,git_repository*,const(git_oid)*);
	alias da_git_blob_lookup_prefix = int function(git_blob**,git_repository*,const(git_oid)*,size_t);
	alias da_git_blob_free = int function(git_blob*);
	alias da_git_blob_id = const(git_oid)* function(const(git_blob)*);
	alias da_git_blob_owner = git_repository* function(const(git_blob)*);
	alias da_git_blob_rawcontent = const(void)* function(const(git_blob)*);
	alias da_git_blob_rawsize = git_off_t function(const(git_blob)*);
	alias da_git_blob_filtered_content = int function(git_buf*,git_blob*,const(char)*,int);
	alias da_git_blob_create_fromworkdir = int function(git_oid*,git_repository*,const(char)*);
	alias da_git_blob_create_fromdisk = int function(git_oid*,git_repository*,const(char)*);
	alias da_git_blob_create_fromstream = int function(git_writestream**,git_repository*,const(char)*);
	alias da_git_blob_create_fromstream_commit = int function(git_oid*,git_writestream*);
	alias da_git_blob_create_frombuffer = int function(git_oid*,git_repository*,const(void)*,size_t);
	alias da_git_blob_is_binary = int function(const(git_blob)*);
	alias da_git_blob_dup = int function(git_blob**,git_blob*);
	// branch.h
	alias da_git_branch_create = int function(git_reference**,git_repository*,const(char)*,const(git_commit)*,int);
	alias da_git_branch_create_from_annotated = int function(git_reference**,git_repository*,const(char)*,const(git_annotated_commit)*,int);
	alias da_git_branch_delete = int function(git_reference*);
	alias da_git_branch_iterator_new = int function(git_branch_iterator**,git_repository*,git_branch_t);
	alias da_git_branch_next = int function(git_reference**,git_branch_t*,git_branch_iterator*);
	alias da_git_branch_iterator_free = void function(git_branch_iterator*);
	alias da_git_branch_move = int function(git_reference**,git_reference*,const(char)*,int);
	alias da_git_branch_lookup = int function(git_reference**,git_repository*,const(char)*,git_branch_t);
	alias da_git_branch_name = int function(const(char)**,const(git_reference)*);
	alias da_git_branch_upstream = int function(git_reference**,const(git_reference)*);
	alias da_git_branch_set_upstream = int function(git_reference*,const(char)*);
	alias da_git_branch_upstream_name = int function(git_buf*,git_repository*,const(char)*);
	alias da_git_branch_is_head = int function(const(git_reference)*);
	alias da_git_branch_remote_name = int function(git_buf*,git_repository*,const(char)*);
	alias da_git_branch_upstream_remote = int function(git_buf*,git_repository*,const(char)*);
	// buffer.h
	alias da_git_buf_free = void function(git_buf*);
	alias da_git_buf_grow = int function(git_buf*,size_t);
	alias da_git_buf_set = int function(git_buf*,const(void)*,size_t);
	alias da_git_buf_is_binary = int function(const(git_buf)*);
	alias da_git_buf_contains_nul = int function(const(git_buf*));
	// checkout.h
	alias da_git_checkout_init_options = int function(git_checkout_options*,uint);
	alias da_git_checkout_head = int function(git_repository*,const(git_checkout_options)*);
	alias da_git_checkout_index = int function(git_repository*,git_index*,const(git_checkout_options)*);
	alias da_git_checkout_tree = int function(git_repository*,const(git_object)*,const(git_checkout_options)*);
	// cherrypick.h
	alias da_git_cherrypick_init_options = int function(git_cherrypick_options*,uint);
	alias da_git_cherrypick_commit = int function(git_index**,git_repository*,git_commit*,git_commit*,uint,const(git_merge_options)*);
	alias da_git_cherrypick = int function(git_repository*,git_commit*,const(git_cherrypick_options)*);
	// clone.h
	alias da_git_clone_init_options = int function(git_clone_options*,uint);
	alias da_git_clone = int function(git_repository**,const(char)*,const(char)*,const(git_clone_options)*);
	// commit.h
	alias da_git_commit_lookup = int function(git_commit**,git_repository*,const(git_oid)*);
	alias da_git_commit_lookup_prefix = int function(git_commit**,git_repository*,const(git_oid)*,size_t);
	alias da_git_commit_free = void function(git_commit*);
	alias da_git_commit_id = const(git_oid)* function(const(git_commit)*);
	alias da_git_commit_owner = git_repository* function(const(git_commit)*);
	alias da_git_commit_message_encoding = const(char)* function(const(git_commit)*);
	alias da_git_commit_message = const(char)* function(const(git_commit)*);
	alias da_git_commit_message_raw = const(char)* function(const(git_commit)*);
	alias da_git_commit_summary = const(char)* function(git_commit*);
	alias da_git_commit_body = const(char)* function(git_commit*);
	alias da_git_commit_time = git_time_t function(const(git_commit)*);
	alias da_git_commit_time_offset = int function(const(git_commit)*);
	alias da_git_commit_committer = const(git_signature)* function(const(git_commit)*);
	alias da_git_commit_author = const(git_signature)* function(const(git_commit)*);
	alias da_git_commit_raw_header = const(char)* function(const(git_commit)*);
	alias da_git_commit_tree = int function(git_tree**,const(git_commit)*);
	alias da_git_commit_tree_id = const(git_oid)* function(const(git_commit)*);
	alias da_git_commit_parentcount = uint function(const(git_commit)*);
	alias da_git_commit_parent = int function(git_commit**,const(git_commit)*,uint);
	alias da_git_commit_parent_id = const(git_oid)* function(const(git_commit)*,uint);
	alias da_git_commit_nth_gen_ancestor = int function(git_commit**,const(git_commit)*,uint);
	alias da_git_commit_header_field = int function(git_buf*,const(git_commit)*,const(char)*);
	alias da_git_commit_extract_signature = int function(git_buf*,git_buf*,git_repository*,git_oid*,const(char)*);
	alias da_git_commit_create = int function(git_oid*,git_repository*,const(char)*,const(git_signature)*,const(git_signature)*,const(char)*,const(char)*,const(git_tree)*,size_t,const(git_commit)*[]);
	alias da_git_commit_create_v = int function(git_oid*,git_repository*,const(char)*,const(git_signature)*,const(git_signature)*,const(char)*,const(char)*,const(git_tree)*,size_t,...);
	alias da_git_commit_amend = int function(git_oid*,const(git_commit)*,const(char)*,const(git_signature)*,const(git_signature)*,const(char)*,const(char)*,const(git_tree)*);
	alias da_git_commit_create_buffer = int function(git_buf*,git_repository*,const(git_signature)*,const(git_signature)*,const(char)*,const(char)*,const(git_tree)*,size_t,const(git_commit)*);
	alias da_git_commit_create_with_signature = int function(git_oid*,git_repository*,const(char)*,const(char)*,const(char)*);
	alias da_git_commit_dup = int function(git_commit**,git_commit*);
	// common.h
	alias da_git_libgit2_version = void function(int*,int*,int*);
	alias da_git_libgit2_features = int function();
	alias da_git_libgit2_opts = int function(int,...);
	// config.h
	alias da_git_config_entry_free = void function(git_config_entry*);
	alias da_git_config_find_global = int function(git_buf*);
	alias da_git_config_find_xdg = int function(git_buf*);
	alias da_git_config_find_system = int function(git_buf*);
	alias da_git_config_find_programdata = int function(git_buf*);
	alias da_git_config_open_default = int function(git_config**);
	alias da_git_config_new = int function(git_config**);
	alias da_git_config_add_file_ondisk = int function(git_config*,const(char)*,git_config_level_t,int);
	alias da_git_config_open_ondisk = int function(git_config**,const(char)*);
	alias da_git_config_open_level = int function(git_config**,const(git_config)*,git_config_level_t);
	alias da_git_config_open_global = int function(git_config**,git_config*);
	alias da_git_config_snapshot = int function(git_config**,git_config*);
	alias da_git_config_free = int function(git_config*);
	alias da_git_config_get_entry = int function(git_config_entry**,const(git_config)*,const(char)*);
	alias da_git_config_get_int32 = int function(int*,const(git_config)*,const(char)*);
	alias da_git_config_get_int64 = int function(long*,const(git_config)*,const(char)*);
	alias da_git_config_get_bool = int function(int*,const(git_config)*,const(char)*);
	alias da_git_config_get_path = int function(git_buf*,const(git_config)*,const(char)*);
	alias da_git_config_get_string = int function(const(char)**,const(git_config)*,const(char)*);
	alias da_git_config_get_string_buf = int function(git_buf*,const(git_config)*,const(char)*);
	alias da_git_config_get_multivar_foreach = int function(const(git_config)*,const(char)*,const(char)*,git_config_foreach_cb,void*);
	alias da_git_config_multivar_iterator_new = int function(git_config_iterator**,const(git_config)*,const(char)*,const(char)*);
	alias da_git_config_next = int function(git_config_entry**,git_config_iterator*);
	alias da_git_config_iterator_free = int function(git_config_iterator*);
	alias da_git_config_set_int32 = int function(git_config*,const(char)*,int);
	alias da_git_config_set_int64 = int function(git_config*,const(char)*,ulong);
	alias da_git_config_set_bool = int function(git_config*,const(char)*,int);
	alias da_git_config_set_string = int function(git_config*,const(char)*,const(char)*);
	alias da_git_config_set_multivar = int function(git_config*,const(char)*,const(char)*,const(char)*);
	alias da_git_config_delete_entry = int function(git_config*,const(char)*);
	alias da_git_config_delete_multivar = int function(git_config*,const(char)*,const(char)*);
	alias da_git_config_foreach = int function(const(git_config)*,git_config_foreach_cb,void*);
	alias da_git_config_iterator_new = int function(git_config_iterator**,const(git_config)*);
	alias da_git_config_iterator_glob_new = int function(git_config_iterator**,const(git_config)*,const(char)*);
	alias da_git_config_foreach_match = int function(const(git_config)*,const(char)*,git_config_foreach_cb,void*);
	alias da_git_config_get_mapped = int function(int*,const(git_config)*,const(char)*,const(git_cvar_map)*,size_t);
	alias da_git_config_lookup_map_value = int function(int*,const(git_cvar_map)*,size_t,const(char)*);
	alias da_git_config_parse_bool = int function(int*,const(char)*);
	alias da_git_config_parse_int32 = int function(int*,const(char)*);
	alias da_git_config_parse_int64 = int function(long*,const(char)*);
	alias da_git_config_parse_path = int function(git_buf*,const(char)*);
	alias da_git_config_backend_foreach_match = int function(git_config_backend*,const(char)*,git_config_foreach_cb,void*);
	alias da_git_config_lock = int function(git_transaction**,git_config*);
	// cred_helpers.h
	alias da_git_cred_userpass = int function(git_cred**,const(char)*,const(char)*,uint,void*);
	alias da_git_describe_init_options = int function(git_describe_options*,uint);
	alias da_git_describe_init_format_options = int function(git_describe_format_options*,uint);
	alias da_git_describe_commit = int function(git_describe_result**,git_object*,git_describe_options*);
	alias da_git_describe_workdir = int function(git_describe_result**,git_repository*,git_describe_options*);
	alias da_git_describe_format = int function(git_buf*,const(git_describe_result)*,const(git_describe_format_options)*);
	alias da_git_describe_result_free = void function(git_describe_result*);
	// diff.h
	alias da_git_diff_init_options = int function(git_diff_options*,uint);
	alias da_git_diff_find_init_options = int function(git_diff_find_options*,uint);
	alias da_git_diff_free = int function(git_diff*);
	alias da_git_diff_tree_to_tree = int function(git_diff**,git_repository*,git_tree*,git_tree*,const(git_diff_options)*);
	alias da_git_diff_tree_to_index = int function(git_diff**,git_repository*,git_tree*,git_index*,const(git_diff_options)*);
	alias da_git_diff_index_to_workdir = int function(git_diff**,git_repository*,git_index*,const(git_diff_options)*);
	alias da_git_diff_tree_to_workdir = int function(git_diff**,git_repository*,git_tree*,git_diff_options*);
	alias da_git_diff_tree_to_workdir_with_index = int function(git_diff**,git_repository*,git_tree*,const(git_diff_options)*);
	alias da_git_diff_index_to_index = int function(git_diff**,git_repository*,git_index*,git_index*,const(git_diff_options)*);
	alias da_git_diff_merge = int function(git_diff*,const(git_diff)*);
	alias da_git_diff_find_similar = int function(git_diff*,const(git_diff_find_options)*);
	alias da_git_diff_num_deltas = size_t function(const(git_diff)*);
	alias da_git_diff_num_deltas_of_type = size_t function(const(git_diff)*,git_delta_t);
	alias da_git_diff_get_delta = const(git_diff_delta)* function(const(git_diff)*,size_t);
	alias da_git_diff_is_sorted_icase = int function(const(git_diff)*);
	alias da_git_diff_foreach = int function(git_diff*,git_diff_file_cb,git_diff_binary_cb,git_diff_hunk_cb,git_diff_line_cb,void*);
	alias da_git_diff_status_char =  char function(git_delta_t);
	alias da_git_diff_print = int function(git_diff*,git_diff_format_t,git_diff_line_cb,void*);
	alias da_git_diff_to_buf = int function(git_buf*,git_diff*,git_diff_format_t);
	alias da_git_diff_blobs = int function(const(git_blob)*,const(char)*,const(git_blob)*,const(char)*,const(git_diff_options)*,git_diff_file_cb,git_diff_binary_cb,git_diff_hunk_cb,git_diff_line_cb,void*);
	alias da_git_diff_blob_to_buffer = int function(const(git_blob)*,const(char)*,const(char)*,size_t,const(char)*,const(git_diff_options)*,git_diff_file_cb,git_diff_binary_cb,git_diff_hunk_cb,git_diff_line_cb,void*);
	alias da_git_diff_buffers = int function(const(void)*,size_t,const(char)*,const(void)*,size_t,const(char)*,const(git_diff_options)*,git_diff_file_cb,git_diff_binary_cb,git_diff_hunk_cb,git_diff_line_cb,void*);
	alias da_git_diff_from_buffer = int function(git_diff**,const(char)*,size_t);
	alias da_git_diff_get_stats = int function(git_diff_stats**,git_diff*);
	alias da_git_diff_stats_files_changed = size_t function(const(git_diff_stats)*);
	alias da_git_diff_stats_insertions = size_t function(const(git_diff_stats)*);
	alias da_git_diff_stats_deletions = size_t function(const(git_diff_stats)*);
	alias da_git_diff_stats_to_buf = int function(git_buf*,const(git_diff_stats)*,git_diff_stats_format_t,size_t);
	alias da_git_diff_stats_free = void function(git_diff_stats*);
	alias da_git_diff_format_email = int function(git_buf*,git_diff*,const(git_diff_format_email_options)*);
	alias da_git_diff_commit_as_email = int function(git_buf*,git_repository*,git_commit*,size_t,size_t,git_diff_format_email_flags_t,const(git_diff_options)*);
	alias da_git_diff_format_email_init_options = int function(git_diff_format_email_options*,uint);
	// errors.h
	alias da_giterr_last = const(git_error)* function();
	alias da_giterr_clear = void function();
	alias da_giterr_set_str = void function(int,const(char)*);
	alias da_giterr_set_oom = void function();
	// filter.h
	alias da_git_filter_list_load = int function(git_filter_list**,git_repository*,git_blob*,const(char)*,git_filter_mode_t,uint);
	alias da_git_filter_list_contains = int function(git_filter_list*,const(char)*);
	alias da_git_filter_list_apply_to_data = int function(git_buf*,git_filter_list*,git_buf*);
	alias da_git_filter_list_apply_to_file = int function(git_buf*,git_filter_list*,git_repository*,const(char)*);
	alias da_git_filter_list_apply_to_blob = int function(git_buf*,git_filter_list*,git_blob*);
	alias da_git_filter_list_stream_data = int function(git_filter_list*,git_buf*,git_writestream*);
	alias da_git_filter_list_stream_file = int function(git_filter_list*,git_repository*,const(char)*,git_writestream*);
	alias da_git_filter_list_stream_blob = int function(git_filter_list*,git_blob*,git_writestream*);
	alias da_git_filter_list_free = void function(git_filter_list*);
	// global.h
	alias da_git_libgit2_init = int function();
	alias da_git_libgit2_shutdown = int function();
	// graph.h
	alias da_git_graph_ahead_behind = int function(size_t*,size_t*,git_repository*,const(git_oid)*,const(git_oid)*);
	alias da_git_graph_descendant_of = int function(git_repository*,const(git_oid)*,const(git_oid)*);
	// ignore.h
	alias da_git_ignore_add_rule = int function(git_repository*,const(char)*);
	alias da_git_ignore_clear_internal_rules = int function(git_repository*);
	alias da_git_ignore_path_is_ignored = int function(int*,git_repository*,const(char)*);
	// index.h
	alias da_git_index_open = int function(git_index**,const(char)*);
	alias da_git_index_new = int function(git_index**);
	alias da_git_index_free = int function(git_index*);
	alias da_git_index_owner = git_repository* function(const(git_index)*);
	alias da_git_index_caps = int function(const(git_index)*);
	alias da_git_index_set_caps = int function(git_index*,int);
	alias da_git_index_version = uint function(git_index*);
	alias da_git_index_set_version = int function(git_index*,uint);
	alias da_git_index_read = int function(git_index*,int);
	alias da_git_index_write = int function(git_index*);
	alias da_git_index_path = const(char)* function(const(git_index)*);
	alias da_git_index_checksum = const(git_oid)* function(git_index *);
	alias da_git_index_read_tree = int function(git_index*,const(git_tree)*);
	alias da_git_index_write_tree = int function(git_oid*,git_index*);
	alias da_git_index_write_tree_to = int function(git_oid*,git_index*,git_repository*);
	alias da_git_index_entrycount = size_t function(const(git_index)*);
	alias da_git_index_clear = int function(git_index*);
	alias da_git_index_get_byindex = const(git_index_entry)* function(git_index*,size_t);
	alias da_git_index_get_bypath = const(git_index_entry)* function(git_index*,const(char)*,int);
	alias da_git_index_remove = int function(git_index*,const(char)*,int);
	alias da_git_index_remove_directory = int function(git_index*,const(char)*,int);
	alias da_git_index_add = int function(git_index*,const(git_index_entry)*);
	alias da_git_index_entry_stage = int function(const(git_index_entry)*);
	alias da_git_index_entry_is_conflict = int function(const(git_index_entry)*);
	alias da_git_index_add_bypath = int function(git_index*,const(char)*);
	alias da_git_index_add_frombuffer = int function(git_index*,const(git_index_entry)*,const(void)*,size_t);
	alias da_git_index_remove_bypath = int function(git_index*,const(char)*);
	alias da_git_index_add_all = int function(git_index*,const(git_strarray)*,uint,git_index_matched_path_cb,void*);
	alias da_git_index_remove_all = int function(git_index*,const(git_strarray)*,git_index_matched_path_cb,void*);
	alias da_git_index_update_all = int function(git_index*,const(git_strarray)*,git_index_matched_path_cb,void*);
	alias da_git_index_find = int function(size_t*,git_index*,const(char)*);
	alias da_git_index_find_prefix = int function(size_t*,git_index*,const(char)*);
	alias da_git_index_conflict_add = int function(git_index*,const(git_index_entry)*,const(git_index_entry)*,const(git_index_entry)*);
	alias da_git_index_conflict_get = int function(const(git_index_entry)**,const(git_index_entry)**,const(git_index_entry)**,git_index*,const(char)*);
	alias da_git_index_conflict_remove = int function(git_index*,const(char)*);
	alias da_git_index_conflict_cleanup = int function(git_index*);
	alias da_git_index_has_conflicts = int function(const(git_index)*);
	alias da_git_index_conflict_iterator_new = int function(git_index_conflict_iterator**,git_index*);
	alias da_git_index_conflict_next = int function(const(git_index_entry)**,const(git_index_entry)**,const(git_index_entry)**,git_index_conflict_iterator*);
	alias da_git_index_conflict_iterator_free = void function(git_index_conflict_iterator*);
	// indexer.h
	alias da_git_indexer_new = int function(git_indexer**,const(char)*,uint,git_odb*,git_transfer_progress_cb,void*);
	alias da_git_indexer_append = int function(git_indexer*,const(void)*,size_t,git_transfer_progress*);
	alias da_git_indexer_commit = int function(git_indexer*,git_transfer_progress*);
	alias da_git_indexer_hash = const(git_oid)* function(const(git_indexer)*);
	alias da_git_indexer_free = void function(git_indexer*);
	// merge.h
	alias da_git_merge_file_init_input = int function(git_merge_file_input*,uint);
	alias da_git_merge_file_init_options = int function(git_merge_file_options*,uint);
	alias da_git_merge_init_options = int function(git_merge_options*,uint);
	alias da_git_merge_analysis = int function(git_merge_analysis_t*,git_merge_preference_t*,git_repository*,const(git_annotated_commit)**,size_t);
	alias da_git_merge_base = int function(git_oid*,git_repository*,const(git_oid)*,const(git_oid)*);
	alias da_git_merge_bases = int function(git_oidarray*,git_repository*,const(git_oid)*,const(git_oid)*);
	alias da_git_merge_base_many = int function(git_oid*,git_repository*,size_t,const(git_oid)[]);
	alias da_git_merge_bases_many = int function(git_oidarray*,git_repository*,size_t,const(git_oid)[]);
	alias da_git_merge_base_octopus = int function(git_oid*,git_repository*,size_t,const(git_oid)[]);
	alias da_git_merge_file = int function(git_merge_file_result*,const(git_merge_file_input)*,const(git_merge_file_input)*,const(git_merge_file_input)*,const(git_merge_file_options)*);
	alias da_git_merge_file_from_index = int function(git_merge_file_result*,git_repository*,const(git_index_entry)*,const(git_index_entry)*,const(git_index_entry)*,const(git_merge_file_options)*);
	alias da_git_merge_file_result_free = void function(git_merge_file_result*);
	alias da_git_merge_trees = int function(git_index**,git_repository*,const(git_tree)*,const(git_tree)*,const(git_tree)*,const(git_merge_options)*);
	alias da_git_merge_commits = int function(git_index**,git_repository*,const(git_commit)*,const(git_commit)*,const(git_merge_options)*);
	alias da_git_merge = int function(git_repository*,const(git_annotated_commit)**,size_t,const(git_merge_options)*,const(git_checkout_options)*);
	// message.h
	alias da_git_message_prettify = int function(git_buf*,const(char)*,int,char);
	// notes.h
	alias da_git_note_iterator_new = int function(git_note_iterator**,git_repository*,const(char)*);
	alias da_git_note_iterator_free = void function(git_note_iterator*);
	alias da_git_note_next = int function(git_oid*,git_oid*,git_note_iterator*);
	alias da_git_note_read = int function(git_note**,git_repository*,const(char)*,const(git_oid)*);
	alias da_git_note_author = const(git_signature)* function(const(git_note)*);
	alias da_git_note_committer = const(git_signature)* function(const(git_note)*);
	alias da_git_note_message = const(char)* function(const(git_note)*);
	alias da_git_note_id = const(git_oid)* function(const(git_note)*);
	alias da_git_note_create = int function(git_oid*,git_repository*,const(char)*,const(git_signature)*,const(git_signature)*,const(git_oid)*,const(char)*,int);
	alias da_git_note_remove = int function(git_repository*,const(char)*,const(git_signature)*,const(git_signature)*,const(git_oid)*);
	alias da_git_note_free = void function(git_note*);
	alias da_git_note_default_ref = int function(git_buf*,git_repository*);
	alias da_git_note_foreach = int function(git_repository*,const(char)*,git_note_foreach_cb,void*);
	// object.h
	alias da_git_object_lookup = int function(git_object**,git_repository*,const(git_oid)*,git_otype);
	alias da_git_object_lookup_prefix = int function(git_object**,git_repository*,const(git_oid)*,size_t,git_otype);
	alias da_git_object_lookup_bypath = int function(git_object**,const(git_object)*,const(char)*,git_otype);
	alias da_git_object_id = const(git_oid)* function(const(git_object)*);
	alias da_git_object_short_id = int function(git_buf*,const(git_object)*);
	alias da_git_object_type = git_otype function(const(git_object)*);
	alias da_git_object_owner = git_repository* function(const(git_object)*);
	alias da_git_object_free = void function(git_object*);
	alias da_git_object_type2string = const(char)* function(git_otype);
	alias da_git_object_string2type = git_otype function(const(char)*);
	alias da_git_object_typeisloose = int function(git_otype);
	alias da_git_object__size = size_t function(git_otype);
	alias da_git_object_peel = int function(git_object**,const(git_object)*,git_otype);
	alias da_git_object_dup = int function(git_object**,git_object*);
	// odb.h
	alias da_git_odb_new = int function(git_odb**);
	alias da_git_odb_open = int function(git_odb**,const(char)*);
	alias da_git_odb_add_disk_alternate = int function(git_odb*,const(char)*);
	alias da_git_odb_free = void function(git_odb*);
	alias da_git_odb_read = int function(git_odb_object**,git_odb*,const(git_oid)*);
	alias da_git_odb_read_prefix = int function(git_odb_object**,git_odb*,const(git_oid)*,size_t);
	alias da_git_odb_read_header = int function(size_t*,git_otype*,git_odb*,const(git_oid)*);
	alias da_git_odb_exists = int function(git_odb*,const(git_oid)*);
	alias da_git_odb_exists_prefix = int function(git_oid*,git_odb*,const(git_oid)*,size_t);
	alias da_git_odb_expand_ids = int function(git_odb*,git_odb_expand_id*,size_t);
	alias da_git_odb_refresh = int function(git_odb*);
	alias da_git_odb_foreach = int function(git_odb*,git_odb_foreach_cb,void*);
	alias da_git_odb_write = int function(git_oid*,git_odb*,const(void)*,size_t,git_otype);
	alias da_git_odb_open_wstream = int function(git_odb_stream**,git_odb*,git_off_t,git_otype);
	alias da_git_odb_stream_write = int function(git_odb_stream*,const(char)*,size_t);
	alias da_git_odb_stream_finalize_write = int function(git_oid*,git_odb_stream*);
	alias da_git_odb_stream_read = int function(git_odb_stream*,char*,size_t);
	alias da_git_odb_stream_free = void function(git_odb_stream*);
	alias da_git_odb_open_rstream = int function(git_odb_stream**,git_odb*,const(git_oid)*);
	alias da_git_odb_write_pack = int function(git_odb_writepack**,git_odb*,git_transfer_progress_cb,void*);
	alias da_git_odb_hash = int function(git_oid*,const(void)*,size_t,git_otype);
	alias da_git_odb_hashfile = int function(git_oid*,const(char)*,git_otype);
	alias da_git_odb_object_dup = int function(git_odb_object**,git_odb_object*);
	alias da_git_odb_object_free = void function(git_odb_object*);
	alias da_git_odb_object_id = const(git_oid)* function(git_odb_object*);
	alias da_git_odb_object_data = const(void)* function(git_odb_object*);
	alias da_git_odb_object_size = size_t function(git_odb_object*);
	alias da_git_odb_object_type = git_otype function(git_odb_object*);
	alias da_git_odb_add_backend = int function(git_odb*,git_odb_backend*,int);
	alias da_git_odb_add_alternate = int function(git_odb*,git_odb_backend*,int);
	alias da_git_odb_num_backends = size_t function(git_odb*);
	alias da_git_odb_get_backend = int function(git_odb_backend**,git_odb*,size_t);
	// odb_backend.h
	alias da_git_odb_backend_pack = int function(git_odb_backend**,const(char)*);
	alias da_git_odb_backend_loose = int function(git_odb_backend**,const(char)*,int,int,uint,uint);
	alias da_git_odb_backend_one_pack = int function(git_odb_backend**,const(char)*);
	// oid.h
	alias da_git_oid_fromstr = int function(git_oid*,const(char)*);
	alias da_git_oid_fromstrp = int function(git_oid*,const(char)*);
	alias da_git_oid_fromstrn = int function(git_oid*,const(char)*,size_t);
	alias da_git_oid_fromraw = void function(git_oid*,const(ubyte)*);
	alias da_git_oid_fmt = void function(char*,const(git_oid)*);
	alias da_git_oid_nfmt = void function(char*,size_t,const(git_oid)*);
	alias da_git_oid_pathfmt = void function(char*,const(git_oid)*);
	alias da_git_oid_tostr_s = char* function(const(git_oid)*);
	alias da_git_oid_tostr = char* function(char*,size_t,const(git_oid)*);
	alias da_git_oid_cpy = void function(git_oid*,const(git_oid)*);
	alias da_git_oid_cmp = int function(const(git_oid)*,const(git_oid)*);
	alias da_git_oid_equal = int function(const(git_oid)*,const(git_oid)*);
	alias da_git_oid_ncmp = int function(const(git_oid)*,const(git_oid)*,size_t);
	alias da_git_oid_streq = int function(const(git_oid)*,const(char)*);
	alias da_git_oid_strcmp = int function(const(git_oid)*,const(char)*);
	alias da_git_oid_iszero = int function(const(git_oid)*);
	alias da_git_oid_shorten_new = git_oid_shorten* function(size_t);
	alias da_git_oid_shorten_add = int function(git_oid_shorten*,const(char)*);
	alias da_git_oid_shorten_free = void function(git_oid_shorten*);
	// oidarray.h
	alias da_git_oidarray_free = void function(git_oidarray*);
	// pack.h
	alias da_git_packbuilder_new = int function(git_packbuilder**,git_repository*);
	alias da_git_packbuilder_set_threads = uint function(git_packbuilder*,uint);
	alias da_git_packbuilder_insert = int function(git_packbuilder*,const(git_oid)*,const(char)*);
	alias da_git_packbuilder_insert_tree = int function(git_packbuilder*,const(git_oid)*);
	alias da_git_packbuilder_insert_commit = int function(git_packbuilder*,const(git_oid)*);
	alias da_git_packbuilder_insert_walk = int function(git_packbuilder*,git_revwalk*);
	alias da_git_packbuilder_insert_recur = int function(git_packbuilder*,const(git_oid)*,const(char)*);
	alias da_git_packbuilder_write_buf = int function(git_buf*,git_packbuilder*);
	alias da_git_packbuilder_write = int function(git_packbuilder*,const(char)*,uint,git_transfer_progress_cb,void*);
	alias da_git_packbuilder_hash = const(git_oid)* function(git_packbuilder*);
	alias da_git_packbuilder_foreach = int function(git_packbuilder*,git_packbuilder_foreach_cb,void*);
	alias da_git_packbuilder_object_count = size_t function(git_packbuilder*);
	alias da_git_packbuilder_written = size_t function(git_packbuilder*);
	alias da_git_packbuilder_set_callbacks = int function(git_packbuilder*,git_packbuilder_progress,void*);
	alias da_git_packbuilder_free = void function(git_packbuilder*);
	// patch.h
	alias da_git_patch_from_diff = int function(git_patch**,git_diff*,size_t);
	alias da_git_patch_from_blobs = int function(git_patch**,const(git_blob)*,const(char)*,const(git_blob)*,const(char)*,const(git_diff_options)*);
	alias da_git_patch_from_blob_and_buffer = int function(git_patch**,const(git_blob)*,const(char)*,const(char)*,size_t,const(char)*,const(git_diff_options)*);
	alias da_git_patch_from_buffers = int function(git_patch**,const(void)*,size_t,const(char)*,const(char)*,size_t,const(char)*,const(git_diff_options)*);
	alias da_git_patch_free = void function(git_patch*);
	alias da_git_patch_get_delta = const(git_diff_delta)* function(const(git_patch)*);
	alias da_git_patch_num_hunks = size_t function(const(git_patch)*);
	alias da_git_patch_line_stats = int function(size_t*,size_t*,size_t*,const(git_patch)*);
	alias da_git_patch_get_hunk = int function(const(git_diff_hunk)**,size_t*,git_patch*,size_t);
	alias da_git_patch_num_lines_in_hunk = int function(const(git_patch)*,size_t);
	alias da_git_patch_get_line_in_hunk = int function(const(git_diff_line)**,git_patch*,size_t,size_t);
	alias da_git_patch_size = size_t function(git_patch*,int,int,int);
	alias da_git_patch_print = int function(git_patch*,git_diff_line_cb,void*);
	alias da_git_patch_to_buf = int function(git_buf*,git_patch*);
	// pathspec.h
	alias da_git_pathspec_new = int function(git_pathspec**,const(git_strarray)*);
	alias da_git_pathspec_free = void function(git_pathspec*);
	alias da_git_pathspec_matches_path = int function(const(git_pathspec)*,uint,const(char)*);
	alias da_git_pathspec_match_workdir = int function(git_pathspec_match_list**,git_repository*,uint,git_pathspec*);
	alias da_git_pathspec_match_index = int function(git_pathspec_match_list**,git_index*,uint,git_pathspec*);
	alias da_git_pathspec_match_tree = int function(git_pathspec_match_list**,git_tree*,uint,git_pathspec*);
	alias da_git_pathspec_match_diff = int function(git_pathspec_match_list**,git_diff*,uint,git_pathspec*);
	alias da_git_pathspec_match_list_free = void function(git_pathspec_match_list*);
	alias da_git_pathspec_match_list_entrycount = size_t function(const(git_pathspec_match_list)*);
	alias da_git_pathspec_match_list_entry = const(char)* function(const(git_pathspec_match_list)*,size_t);
	alias da_git_pathspec_match_list_diff_entry = const(git_diff_delta)* function(const(git_pathspec_match_list)*,size_t);
	alias da_git_pathspec_match_list_failed_entrycount = size_t function(const(git_pathspec_match_list)*);
	alias da_git_pathspec_match_list_failed_entry = const(char)* function(const(git_pathspec_match_list)*,size_t);
	// proxy.h
	alias da_git_proxy_init_options = int function(git_proxy_options*,uint);
	// rebase.h
	alias da_git_rebase_init_options = int function(git_rebase_options*,uint);
	alias da_git_rebase_init = int function(git_rebase**,git_repository*,const(git_annotated_commit)*,const(git_annotated_commit)*,const(git_annotated_commit)*,const(git_rebase_options)*);
	alias da_git_rebase_open = int function(git_rebase**,git_repository*,const(git_rebase_options)*);
	alias da_git_rebase_operation_entrycount = size_t function(git_rebase*);
	alias da_git_rebase_operation_current = size_t function(git_rebase*);
	alias da_git_rebase_operation_byindex = git_rebase_operation* function(git_rebase*,size_t);
	alias da_git_rebase_next = int function(git_rebase_operation**,git_rebase*);
	alias da_git_rebase_inmemory_index = int function(git_index**,git_rebase*);
	alias da_git_rebase_commit = int function(git_oid*,git_rebase*,const(git_signature)*,const(git_signature)*,const(char)*,const(char)*);
	alias da_git_rebase_abort = int function(git_rebase*);
	alias da_git_rebase_finish = int function(git_rebase*,const(git_signature)*);
	alias da_git_rebase_free = void function(git_rebase*);
	// refdb.h
	alias da_git_refdb_new = int function(git_refdb**,git_repository*);
	alias da_git_refdb_open = int function(git_refdb**,git_repository*);
	alias da_git_refdb_compress = int function(git_refdb*);
	alias da_git_refdb_free = void function(git_refdb*);
	// reflog.h
	alias da_git_reflog_read = int function(git_reflog**,git_repository*,const(char)*);
	alias da_git_reflog_write = int function(git_reflog*);
	alias da_git_reflog_append = int function(git_reflog*,const(git_oid)*,const(git_signature)*,const(char)*);
	alias da_git_reflog_rename = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_reflog_delete = int function(git_repository*,const(char)*);
	alias da_git_reflog_entrycount = size_t function(git_reflog*);
	alias da_git_reflog_entry_byindex = const(git_reflog_entry)* function(const(git_reflog)*,size_t);
	alias da_git_reflog_drop = int function(git_reflog*,size_t,int);
	alias da_git_reflog_entry_id_old = const(git_oid)* function(const(git_reflog_entry)*);
	alias da_git_reflog_entry_id_new = const(git_oid)* function(const(git_reflog_entry)*);
	alias da_git_reflog_entry_committer = const(git_signature)* function(const(git_reflog_entry)*);
	alias da_git_reflog_entry_message = const(char)* function(const(git_reflog_entry)*);
	alias da_git_reflog_free = void function(git_reflog*);
	// refs.h
	alias da_git_reference_lookup = int function(git_reference**,git_repository*,const(char)*);
	alias da_git_reference_name_to_id = int function(git_oid*,git_repository*,const(char)*);
	alias da_git_reference_dwim = int function(git_reference**,git_repository*,const(char)*);
	alias da_git_reference_symbolic_create_matching = int function(git_reference**,git_repository*,const(char)*,const(char)*,int,const(char)*,const(char)*);
	alias da_git_reference_symbolic_create = int function(git_reference**,git_repository*,const(char)*,const(char)*,int,const(char)*);
	alias da_git_reference_create = int function(git_reference**,git_repository*,const(char)*,const(git_oid)*,int,const(char)*);
	alias da_git_reference_create_matching = int function(git_reference**,git_repository*,const(char)*,const(git_oid)*,int,const(git_oid)*,const(char)*);
	alias da_git_reference_target = const(git_oid)* function(const(git_reference)*);
	alias da_git_reference_target_peel = const(git_oid)* function(const(git_reference)*);
	alias da_git_reference_symbolic_target = const(char)* function(const(git_reference)*);
	alias da_git_reference_type = git_ref_t function(const(git_reference)*);
	alias da_git_reference_name = const(char)* function(const(git_reference)*);
	alias da_git_reference_resolve = int function(git_reference**,const(git_reference)*);
	alias da_git_reference_owner = git_repository* function(const(git_reference)*);
	alias da_git_reference_symbolic_set_target = int function(git_reference**,git_reference*,const(char)*,const(char)*);
	alias da_git_reference_set_target = int function(git_reference**,git_reference*,const(git_oid)*,const(char)*);
	alias da_git_reference_rename = int function(git_reference**,git_reference*,const(char)*,int,const(char)*);
	alias da_git_reference_delete = int function(git_reference*);
	alias da_git_reference_remove = int function(git_repository*,const(char)*);
	alias da_git_reference_list = int function(git_strarray*,git_repository*);
	alias da_git_reference_foreach = int function(git_repository*,git_reference_foreach_cb,void*);
	alias da_git_reference_foreach_name = int function(git_repository*,git_reference_foreach_name_cb,void*);
	alias da_git_reference_dup = int function(git_reference**,git_reference*);
	alias da_git_reference_free = void function(git_reference*);
	alias da_git_reference_cmp = int function(const(git_reference)*,const(git_reference)*);
	alias da_git_reference_iterator_new = int function(git_reference_iterator**,git_repository*);
	alias da_git_reference_iterator_glob_new = int function(git_reference_iterator**,git_repository*,const(char)*);
	alias da_git_reference_next = int function(git_reference**,git_reference_iterator*);
	alias da_git_reference_next_name = int function(const(char)**,git_reference_iterator*);
	alias da_git_reference_iterator_free = void function(git_reference_iterator*);
	alias da_git_reference_foreach_glob = int function(git_repository*,const(char)*,git_reference_foreach_name_cb,void*);
	alias da_git_reference_has_log = int function(git_repository*,const(char)*);
	alias da_git_reference_ensure_log = int function(git_repository*,const(char)*);
	alias da_git_reference_is_branch = int function(const(git_reference)*);
	alias da_git_reference_is_remote = int function(const(git_reference)*);
	alias da_git_reference_is_tag = int function(const(git_reference)*);
	alias da_git_reference_is_note = int function(const(git_reference)*);
	alias da_git_reference_normalize_name = int function(char*,size_t,const(char)*,uint);
	alias da_git_reference_peel = int function(git_object**,git_reference*,git_otype);
	alias da_git_reference_is_valid_name = int function(const(char)*);
	alias da_git_reference_shorthand = const(char)* function(const(git_reference)*);
	// refspec.h
	alias da_git_refspec_src = const(char)* function(const(git_refspec)*);
	alias da_git_refspec_dst = const(char)* function(const(git_refspec)*);
	alias da_git_refspec_string = const(char)* function(const(git_refspec)*);
	alias da_git_refspec_force = int function(const(git_refspec)*);
	alias da_git_refspec_direction = git_direction function(const(git_refspec)*);
	alias da_git_refspec_src_matches = int function(const(git_refspec)*,const(char)*);
	alias da_git_refspec_dst_matches = int function(const(git_refspec)*,const(char)*);
	alias da_git_refspec_transform = int function(git_buf*,const(git_refspec)*,const(char)*);
	alias da_git_refspec_rtransform = int function(git_buf*,const(git_refspec)*,const(char)*);
	// remote.h
	alias da_git_remote_create = int function(git_remote**,git_repository*,const(char)*,const(char)*);
	alias da_git_remote_create_with_fetchspec = int function(git_remote**,git_repository*,const(char)*,const(char)*,const(char)*);
	alias da_git_remote_create_anonymous = int function(git_remote**,git_repository*,const(char)*);
	alias da_git_remote_lookup = int function(git_remote**,git_repository*,const(char)*);
	alias da_git_remote_dup = int function(git_remote**,git_remote*);
	alias da_git_remote_owner = git_repository* function(const(git_remote)*);
	alias da_git_remote_name = const(char)* function(const(git_remote)*);
	alias da_git_remote_url = const(char)* function(const(git_remote)*);
	alias da_git_remote_pushurl = const(char)* function(const(git_remote)*);
	alias da_git_remote_set_url = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_remote_set_pushurl = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_remote_add_fetch = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_remote_get_fetch_refspecs = int function(git_strarray*,const(git_remote)*);
	alias da_git_remote_add_push = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_remote_get_push_refspecs = int function(git_strarray*,const(git_remote)*);
	alias da_git_remote_refspec_count = size_t function(const(git_remote)*);
	alias da_git_remote_get_refspec = const(git_refspec)* function(const(git_remote)*,size_t);
	alias da_git_remote_connect = int function(git_remote*,git_direction,const(git_remote_callbacks)*,const(git_proxy_options)*,const(git_strarray)*);
	alias da_git_remote_ls = int function(const(git_remote_head)***,size_t*,git_remote*);
	alias da_git_remote_connected = int function(const(git_remote)*);
	alias da_git_remote_stop = void function(git_remote*);
	alias da_git_remote_disconnect = void function(git_remote*);
	alias da_git_remote_free = void function(git_remote*);
	alias da_git_remote_list = int function(git_strarray*,git_repository*);
	alias da_git_remote_init_callbacks = int function(git_remote_callbacks*,uint);
	alias da_git_fetch_init_options = int function(git_fetch_options*,uint);
	alias da_git_push_init_options = int function(git_push_options*,uint);
	alias da_git_remote_download = int function(git_remote*,const(git_strarray)*,const(git_fetch_options)*);
	alias da_git_remote_upload = int function(git_remote*,const(git_strarray)*,const(git_push_options)*);
	alias da_git_remote_update_tips = int function(git_remote*,const(git_remote_callbacks)*,int,git_remote_autotag_option_t,const(char)*);
	alias da_git_remote_fetch = int function(git_remote*,const(git_strarray)*,const(git_fetch_options)*,const(char)*);
	alias da_git_remote_prune = int function(git_remote*,const(git_remote_callbacks)*);
	alias da_git_remote_push = int function(git_remote*,const(git_strarray)*,const(git_push_options)*);
	alias da_git_remote_stats = const(git_transfer_progress)* function(git_remote*);
	alias da_git_remote_autotag = git_remote_autotag_option_t function(const(git_remote)*);
	alias da_git_remote_set_autotag = int function(git_repository*,const(char)*,git_remote_autotag_option_t);
	alias da_git_remote_prune_refs = int function(const(git_remote)*);
	alias da_git_remote_rename = int function(git_strarray*,git_repository*,const(char)*,const(char)*);
	alias da_git_remote_is_valid_name = int function(const(char)*);
	alias da_git_remote_delete = int function(git_repository*,const(char)*);
	alias da_git_remote_default_branch = int function(git_buf*,git_remote*);
	// repository.h
	alias da_git_repository_open = int function(git_repository**,const(char)*);
	alias da_git_repository_wrap_odb = int function(git_repository**,git_odb*);
	alias da_git_repository_discover = int function(git_buf*,const(char)*,int,const(char)*);
	alias da_git_repository_open_ext = int function(git_repository**,const(char)*,uint,const(char)*);
	alias da_git_repository_open_bare = int function(git_repository**,const(char)*);
	alias da_git_repository_free = void function(git_repository*);
	alias da_git_repository_init = int function(git_repository**,const(char)*,uint);
	alias da_git_repository_init_init_options = int function(git_repository_init_options*,uint);
	alias da_git_repository_init_ext = int function(git_repository**,const(char)*,git_repository_init_options*);
	alias da_git_repository_head = int function(git_reference**,git_repository*);
	alias da_git_repository_head_detached = int function(git_repository*);
	alias da_git_repository_head_unborn = int function(git_repository*);
	alias da_git_repository_is_empty = int function(git_repository*);
	alias da_git_repository_path = const(char)* function(git_repository*);
	alias da_git_repository_workdir = const(char)* function(git_repository*);
	alias da_git_repository_set_workdir = int function(git_repository*,const(char)*,int);
	alias da_git_repository_is_bare = int function(git_repository*);
	alias da_git_repository_config = int function(git_config**,git_repository*);
	alias da_git_repository_config_snapshot = int function(git_config**,git_repository*);
	alias da_git_repository_odb = int function(git_odb**,git_repository*);
	alias da_git_repository_refdb = int function(git_refdb**,git_repository*);
	alias da_git_repository_index = int function(git_index**,git_repository*);
	alias da_git_repository_message = int function(git_buf*,git_repository*);
	alias da_git_repository_message_remove = int function(git_repository*);
	alias da_git_repository_state_cleanup = int function(git_repository*);
	alias da_git_repository_fetchhead_foreach = int function(git_repository*,git_repository_fetchhead_foreach_cb,void*);
	alias da_git_repository_mergehead_foreach = int function(git_repository*,git_repository_mergehead_foreach_cb,void*);
	alias da_git_repository_hashfile = int function(git_oid*,git_repository*,const(char)*,git_otype,const(char)*);
	alias da_git_repository_set_head = int function(git_repository*,const(char)*);
	alias da_git_repository_set_head_detached = int function(git_repository*,const(git_oid)*);
	alias da_git_repository_set_head_detached_from_annotated = int function(git_repository*,const(git_annotated_commit)*);
	alias da_git_repository_detach_head = int function(git_repository*);
	alias da_git_repository_state = int function(git_repository*);
	alias da_git_repository_set_namespace = int function(git_repository*,const(char)*);
	alias da_git_repository_get_namespace = const(char)* function(git_repository*);
	alias da_git_repository_is_shallow = int function(git_repository*);
	alias da_git_repository_ident = int function(const(char)**,const(char)**,const(git_repository)*);
	alias da_git_repository_set_ident = int function(git_repository*,const(char)*,const(char)*);
	// reset.h
	alias da_git_reset = int function(git_repository*,git_object*,git_reset_t,const(git_checkout_options)*);
	alias da_git_reset_from_annotated = int function(git_repository*,git_annotated_commit*,git_reset_t,const(git_checkout_options)*);
	alias da_git_reset_default = int function(git_repository*,git_object*,git_strarray*);
	// revert.h
	alias da_git_revert_init_options = int function(git_revert_options*,uint);
	alias da_git_revert_commit = int function(git_index**,git_repository*,git_commit*,git_commit*,uint,const(git_merge_options)*);
	alias da_git_revert = int function(git_repository*,git_commit*,const(git_revert_options)*);
	// revparse.h
	alias da_git_revparse_single = int function(git_object**,git_repository*,const(char)*);
	alias da_git_revparse_ext = int function(git_object**,git_reference**,git_repository*,const(char)*);
	alias da_git_revparse = int function(git_revspec*,git_repository*,const(char)*);
	// revwalk.h
	alias da_git_revwalk_new = int function(git_revwalk**,git_repository*);
	alias da_git_revwalk_reset = void function(git_revwalk*);
	alias da_git_revwalk_push = int function(git_revwalk*,const(git_oid)*);
	alias da_git_revwalk_push_glob = int function(git_revwalk*,const(char)*);
	alias da_git_revwalk_push_head = int function(git_revwalk*);
	alias da_git_revwalk_hide = int function(git_revwalk*,const(git_oid)*);
	alias da_git_revwalk_hide_glob = int function(git_revwalk*,const(char)*);
	alias da_git_revwalk_hide_head = int function(git_revwalk*);
	alias da_git_revwalk_push_ref = int function(git_revwalk*,const(char)*);
	alias da_git_revwalk_hide_ref = int function(git_revwalk*,const(char)*);
	alias da_git_revwalk_next = int function(git_oid*,git_revwalk*);
	alias da_git_revwalk_sorting = void function(git_revwalk*,uint);
	alias da_git_revwalk_push_range = int function(git_revwalk*,const(char)*);
	alias da_git_revwalk_simplify_first_parent = void function(git_revwalk*);
	alias da_git_revwalk_free = void function(git_revwalk*);
	alias da_git_revwalk_repository = git_repository* function(git_revwalk*);
	alias da_git_revwalk_add_hide_cb = int function(git_revwalk*,git_revwalk_hide_cb,void*);
	// signature.h
	alias da_git_signature_new = int function(git_signature**,const(char)*,const(char)*,git_time_t,int);
	alias da_git_signature_now = int function(git_signature**,const(char)*,const(char)*);
	alias da_git_signature_default = int function(git_signature**,git_repository*);
	alias da_git_signature_from_buffer = int function(git_signature**,const(char)*);
	alias da_git_signature_dup = int function(git_signature**,const(git_signature)*);
	alias da_git_signature_free = void function(git_signature*);
	// stash.h
	alias da_git_stash_save = int function(git_oid*,git_repository*,const(git_signature)*,const(char)*,uint);
	alias da_git_stash_apply_init_options = int function(git_stash_apply_options*,uint);
	alias da_git_stash_apply = int function(git_repository*,size_t,const(git_stash_apply_options)*);
	alias da_git_stash_foreach = int function(git_repository*,git_stash_cb,void*);
	alias da_git_stash_drop = int function(git_repository*,size_t);
	alias da_git_stash_pop = int function(git_repository*,size_t,const(git_stash_apply_options)*);
	// status.h
	alias da_git_status_init_options = int function(git_status_options*,uint);
	alias da_git_status_foreach = int function(git_repository*,git_status_cb,void*);
	alias da_git_status_foreach_ext = int function(git_repository*,const(git_status_options)*,git_status_cb,void*);
	alias da_git_status_file = int function(uint*,git_repository*,const(char)*);
	alias da_git_status_list_new = int function(git_status_list**,git_repository*,const(git_status_options)*);
	alias da_git_status_list_entrycount = size_t function(git_status_list*);
	alias da_git_status_byindex = const(git_status_entry)* function(git_status_list*,size_t);
	alias da_git_status_list_free = void function(git_status_list*);
	alias da_git_status_should_ignore = int function(int*,git_repository*,const(char)*);
	// strarray.h
	alias da_git_strarray_free = void function(git_strarray*);
	alias da_git_strarray_copy = int function(git_strarray*,const(git_strarray)*);
	// submodule.h
	alias da_git_submodule_update_init_options = int function(git_submodule_update_options*,uint);
	alias da_git_submodule_update = int function(git_submodule*,int,git_submodule_update_options*);
	alias da_git_submodule_lookup = int function(git_submodule**,git_repository*,const(char)*);
	alias da_git_submodule_free = void function(git_submodule*);
	alias da_git_submodule_foreach = int function(git_repository*,git_submodule_cb,void*);
	alias da_git_submodule_add_setup = int function(git_submodule**,git_repository*,const(char)*,const(char)*,int);
	alias da_git_submodule_add_finalize = int function(git_submodule*);
	alias da_git_submodule_add_to_index = int function(git_submodule*,int);
	alias da_git_submodule_owner = git_repository* function(git_submodule*);
	alias da_git_submodule_name = const(char)* function(git_submodule*);
	alias da_git_submodule_path = const(char)* function(git_submodule*);
	alias da_git_submodule_url = const(char)* function(git_submodule*);
	alias da_git_submodule_resolve_url = int function(git_buf*,git_repository*,const(char)*);
	alias da_git_submodule_branch = const(char)* function(git_submodule*);
	alias da_git_submodule_set_branch = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_submodule_set_url = int function(git_repository*,const(char)*,const(char)*);
	alias da_git_submodule_index_id = const(git_oid)* function(git_submodule*);
	alias da_git_submodule_head_id = const(git_oid)* function(git_submodule*);
	alias da_git_submodule_wd_id = const(git_oid)* function(git_submodule*);
	alias da_git_submodule_ignore = git_submodule_ignore_t function(git_submodule*);
	alias da_git_submodule_set_ignore = int function(git_repository*,const(char)*,git_submodule_ignore_t);
	alias da_git_submodule_update_strategy = git_submodule_update_t function(git_submodule*);
	alias da_git_submodule_set_update = int function(git_repository*,const(char)*,git_submodule_update_t);
	alias da_git_submodule_fetch_recurse_submodules = git_submodule_recurse_t function(git_submodule*);
	alias da_git_submodule_set_fetch_recurse_submodules = int function(git_repository*,const(char)*,git_submodule_recurse_t);
	alias da_git_submodule_init = int function(git_submodule*,int);
	alias da_git_submodule_repo_init = int function(git_repository**,const(git_submodule)*,int);
	alias da_git_submodule_sync = int function(git_submodule*);
	alias da_git_submodule_open = int function(git_repository**,git_submodule*);
	alias da_git_submodule_reload = int function(git_submodule*,int);
	alias da_git_submodule_status = int function(uint*,git_repository*,const(char)*,git_submodule_ignore_t);
	alias da_git_submodule_location = int function(uint*,git_submodule*);
	// tag.h
	alias da_git_tag_lookup = int function(git_tag**,git_repository*,const(git_oid)*);
	alias da_git_tag_lookup_prefix = int function(git_tag**,git_repository*,const(git_oid)*,size_t);
	alias da_git_tag_free = void function(git_tag*);
	alias da_git_tag_id = const(git_oid)* function(const(git_tag)*);
	alias da_git_tag_owner = git_repository* function(const(git_tag)*);
	alias da_git_tag_target = int function(git_object**,const(git_tag)*);
	alias da_git_tag_target_id = const(git_oid)* function(const(git_tag)*);
	alias da_git_tag_target_type = git_otype function(const(git_tag)*);
	alias da_git_tag_message = const(char)* function(const(git_tag)*);
	alias da_git_tag_create = int function(git_oid*,git_repository*,const(char)*,const(git_object)*,const(git_signature)*,const(char)*,int);
	alias da_git_tag_annotation_create = int function(git_oid*,git_repository*,const(char)*,const(git_object)*,const(git_signature)*,const(char)*);
	alias da_git_tag_create_frombuffer = int function(git_oid*,git_repository*,const(char)*,int);
	alias da_git_tag_create_lightweight = int function(git_oid*,git_repository*,const(char)*,const(git_object)*,int);
	alias da_git_tag_delete = int function(git_repository*,const(char)*);
	alias da_git_tag_list = int function(git_strarray*,git_repository*);
	alias da_git_tag_list_match = int function(git_strarray*,const(char)*,git_repository*);
	alias da_git_tag_foreach = int function(git_repository*,git_tag_foreach_cb,void*);
	alias da_git_tag_peel = int function(git_object**,const(git_tag)*);
	alias da_git_tag_dup = int function(git_tag**,git_tag*);
	// trace.h
	alias da_git_trace_set = int function(git_trace_level_t,git_trace_callback);
	// transaction.h
	alias da_git_transaction_new = int function(git_transaction**,git_repository*);
	alias da_git_transaction_lock_ref = int function(git_transaction*,const(char)*);
	alias da_git_transaction_set_target = int function(git_transaction*,const(char)*,const(git_oid)*,const(git_signature)*,const(char)*);
	alias da_git_transaction_set_symbolic_target = int function(git_transaction*,const(char)*,const(char)*,const(git_signature)*,const(char)*);
	alias da_git_transaction_set_reflog = int function(git_transaction*,const(char)*,const(git_reflog)*);
	alias da_git_transaction_remove = int function(git_transaction*,const(char)*);
	alias da_git_transaction_commit = int function(git_transaction*);
	alias da_git_transaction_free = void function(git_transaction*);
	// transport.h
	alias da_git_cred_has_username = int function(git_cred*);
	alias da_git_cred_userpass_plaintext_new = int function(git_cred**,const(char)*,const(char)*);
	alias da_git_cred_ssh_key_new = int function(git_cred**,const(char)*,const(char)*,const(char)*,const(char)*);
	alias da_git_cred_ssh_interactive_new = int function(git_cred**,const(char)*,git_cred_ssh_interactive_callback,void*);
	alias da_git_cred_ssh_key_from_agent = int function(git_cred**,const(char)*);
	alias da_git_cred_ssh_custom_new = int function(git_cred**,const(char)*,const(char)*,size_t,git_cred_sign_callback,void*);
	alias da_git_cred_default_new = int function(git_cred**);
	alias da_git_cred_username_new = int function(git_cred**,const(char)*);
	alias da_git_cred_ssh_key_memory_new = int function(git_cred**,const(char)*,const(char)*,const(char)*,const(char)*);
	alias da_git_cred_free = void function(git_cred*);
	// tree.h
	alias da_git_tree_lookup = int function(git_tree**,git_repository*,const(git_oid)*);
	alias da_git_tree_lookup_prefix = int function(git_tree**,git_repository*,const(git_oid)*,size_t);
	alias da_git_tree_free = void function(git_tree*);
	alias da_git_tree_id = const(git_oid)* function(const(git_tree)*);
	alias da_git_tree_owner = git_repository* function(const(git_tree)*);
	alias da_git_tree_entrycount = size_t function(const(git_tree)*);
	alias da_git_tree_entry_byname = const(git_tree_entry)* function(const(git_tree)*,const(char)*);
	alias da_git_tree_entry_byindex = const(git_tree_entry)* function(const(git_tree)*,size_t);
	alias da_git_tree_entry_byid = const(git_tree_entry)* function(const(git_tree)*,const(git_oid)*);
	alias da_git_tree_entry_bypath = int function(git_tree_entry**,const(git_tree)*,const(char)*);
	alias da_git_tree_entry_dup = int function(git_tree_entry**,const(git_tree_entry)*);
	alias da_git_tree_entry_free = void function(git_tree_entry*);
	alias da_git_tree_entry_name = const(char)* function(const(git_tree_entry)*);
	alias da_git_tree_entry_id = const(git_oid)* function(const(git_tree_entry)*);
	alias da_git_tree_entry_type = git_otype function(const(git_tree_entry)*);
	alias da_git_tree_entry_filemode = git_filemode_t function(const(git_tree_entry)*);
	alias da_git_tree_entry_filemode_raw = git_filemode_t function(const(git_tree_entry)*);
	alias da_git_tree_entry_cmp = int function(const(git_tree_entry)*,const(git_tree_entry)*);
	alias da_git_tree_entry_to_object = int function(git_object**,git_repository*,const(git_tree_entry)*);
	alias da_git_treebuilder_new = int function(git_treebuilder**,git_repository*,const(git_tree)*);
	alias da_git_treebuilder_clear = void function(git_treebuilder*);
	alias da_git_treebuilder_entrycount = uint function(git_treebuilder*);
	alias da_git_treebuilder_free = void function(git_treebuilder*);
	alias da_git_treebuilder_get = const(git_tree_entry)* function(git_treebuilder*,const(char)*);
	alias da_git_treebuilder_insert = int function(const(git_tree_entry)**,git_treebuilder*,const(char)*,const(git_oid)*,git_filemode_t);
	alias da_git_treebuilder_remove = int function(git_treebuilder*,const(char)*);
	alias da_git_treebuilder_filter = void function(git_treebuilder*,git_treebuilder_filter_cb,void*);
	alias da_git_treebuilder_write = int function(git_oid*,git_treebuilder*);
	alias da_git_tree_walk = int function(const(git_tree)*,git_treewalk_mode,git_treewalk_cb,void*);
	alias da_git_tree_dup = int function(git_tree**,git_tree*);
	alias da_git_tree_create_updated = int function(git_oid*,git_repository*,git_tree*,size_t,const(git_tree_update)*);

	// ADDED IN v0.26.0 RC1, RC2
	// repository.h
	alias da_git_repository_item_path = int function(git_buf*,git_repository*,git_repository_item_t);
	alias da_git_repository_commondir = const(char)* function(git_repository*);
	alias da_git_repository_submodule_cache_all = int function(git_repository*);
	alias da_git_repository_submodule_cache_clear = int function(git_repository*);

	// branch.h
	alias da_git_branch_is_checked_out = int function(const(git_reference)*);

	// transport.h
	alias da_git_transport_smart_proxy_options = int function(git_proxy_options*,git_transport*);

	// worktree.h
	alias da_git_worktree_list = int function(git_strarray*,git_repository*);
	alias da_git_worktree_lookup = int function(git_worktree**,git_repository*,const(char)*);
	alias da_git_worktree_open_from_repository = int function(git_worktree**,git_repository*);
	alias da_git_worktree_free = void function(git_worktree*);
	alias da_git_worktree_validate = int function(const(git_worktree)*);
	alias da_git_worktree_add_init_options = int function(git_worktree_add_options*,uint);
	alias da_git_worktree_add = int function(git_worktree**,git_repository*,const(char)*,const(char)*,const(git_worktree_add_options)*);
	alias da_git_worktree_lock = int function(git_worktree*,char*);
	alias da_git_worktree_unlock = int function(git_worktree*);
	alias da_it_worktree_is_locked = int function(git_buf*,const(git_worktree)*);
	alias da_git_worktree_prune_init_options = int function(git_worktree_prune_options*,uint);
	alias da_git_worktree_is_prunable = int function(git_worktree*,git_worktree_prune_options*);
	alias da_git_worktree_prune = int function(git_worktree*,git_worktree_prune_options*);
}

__gshared {
	// annotated_commit.h
	da_git_annotated_commit_from_ref git_annotated_commit_from_ref;
	da_git_annotated_commit_from_fetchhead git_annotated_commit_from_fetchhead;
	da_git_annotated_commit_lookup git_annotated_commit_lookup;
	da_git_annotated_commit_from_revspec git_annotated_commit_from_revspec;
	da_git_annotated_commit_id git_annotated_commit_id;
	// attr.h
	da_git_attr_value git_attr_value;
	da_git_attr_get git_attr_get;
	da_git_attr_get_many git_attr_get_many;
	da_git_attr_foreach git_attr_foreach;
	da_git_attr_cache_flush git_attr_cache_flush;
	da_git_attr_add_macro git_attr_add_macro;
	// blame.h
	da_git_blame_init_options git_blame_init_options;
	da_git_blame_get_hunk_byindex git_blame_get_hunk_byindex;
	da_git_blame_get_hunk_byline git_blame_get_hunk_byline;
	da_git_blame_file git_blame_file;
	da_git_blame_buffer git_blame_buffer;
	da_git_blame_free git_blame_free;
	// blob.h
	da_git_blob_lookup git_blob_lookup;
	da_git_blob_lookup_prefix git_blob_lookup_prefix;
	da_git_blob_free git_blob_free;
	da_git_blob_id git_blob_id;
	da_git_blob_owner git_blob_owner;
	da_git_blob_rawcontent git_blob_rawcontent;
	da_git_blob_rawsize git_blob_rawsize;
	da_git_blob_filtered_content git_blob_filtered_content;
	da_git_blob_create_fromworkdir git_blob_create_fromworkdir;
	da_git_blob_create_fromdisk git_blob_create_fromdisk;
	da_git_blob_create_fromstream git_blob_create_fromstream;
	da_git_blob_create_fromstream_commit git_blob_create_fromstream_commit;
	da_git_blob_create_frombuffer git_blob_create_frombuffer;
	da_git_blob_is_binary git_blob_is_binary;
	da_git_blob_dup git_blob_dup;
	// branch.h
	da_git_branch_create git_branch_create;
	da_git_branch_create_from_annotated git_branch_create_from_annotated;
	da_git_branch_delete git_branch_delete;
	da_git_branch_iterator_new git_branch_iterator_new;
	da_git_branch_next git_branch_next;
	da_git_branch_iterator_free git_branch_iterator_free;
	da_git_branch_move git_branch_move;
	da_git_branch_lookup git_branch_lookup;
	da_git_branch_name git_branch_name;
	da_git_branch_upstream git_branch_upstream;
	da_git_branch_set_upstream git_branch_set_upstream;
	da_git_branch_upstream_name git_branch_upstream_name;
	da_git_branch_is_head git_branch_is_head;
	da_git_branch_remote_name git_branch_remote_name;
	da_git_branch_upstream_remote git_branch_upstream_remote;
	// buffer.h
	da_git_buf_free git_buf_free;
	da_git_buf_grow git_buf_grow;
	da_git_buf_set git_buf_set;
	da_git_buf_is_binary git_buf_is_binary;
	da_git_buf_contains_nul git_buf_contains_nul;
	// checkout.h
	da_git_checkout_init_options git_checkout_init_options;
	da_git_checkout_head git_checkout_head;
	da_git_checkout_index git_checkout_index;
	da_git_checkout_tree git_checkout_tree;
	// cherrypick.h
	da_git_cherrypick_init_options git_cherrypick_init_options;
	da_git_cherrypick_commit git_cherrypick_commit;
	da_git_cherrypick git_cherrypick;
	// clone.h
	da_git_clone_init_options git_clone_init_options;
	da_git_clone git_clone;
	// commit.h
	da_git_commit_lookup git_commit_lookup;
	da_git_commit_lookup_prefix git_commit_lookup_prefix;
	da_git_commit_free git_commit_free;
	da_git_commit_id git_commit_id;
	da_git_commit_owner git_commit_owner;
	da_git_commit_message_encoding git_commit_message_encoding;
	da_git_commit_message git_commit_message;
	da_git_commit_message_raw git_commit_message_raw;
	da_git_commit_summary git_commit_summary;
	da_git_commit_body git_commit_body;
	da_git_commit_time git_commit_time;
	da_git_commit_time_offset git_commit_time_offset;
	da_git_commit_committer git_commit_committer;
	da_git_commit_author git_commit_author;
	da_git_commit_raw_header git_commit_raw_header;
	da_git_commit_tree git_commit_tree;
	da_git_commit_tree_id git_commit_tree_id;
	da_git_commit_parentcount git_commit_parentcount;
	da_git_commit_parent git_commit_parent;
	da_git_commit_parent_id git_commit_parent_id;
	da_git_commit_nth_gen_ancestor git_commit_nth_gen_ancestor;
	da_git_commit_header_field git_commit_header_field;
	da_git_commit_extract_signature git_commit_extract_signature;
	da_git_commit_create git_commit_create;
	da_git_commit_create_v git_commit_create_v;
	da_git_commit_amend git_commit_amend;
	da_git_commit_create_buffer git_commit_create_buffer;
	da_git_commit_create_with_signature git_commit_create_with_signature;
	da_git_commit_dup git_commit_dup;
	// common.h
	da_git_libgit2_version git_libgit2_version;
	da_git_libgit2_features git_libgit2_features;
	da_git_libgit2_opts git_libgit2_opts;
	// config.h
	da_git_config_entry_free git_config_entry_free;
	da_git_config_find_global git_config_find_global;
	da_git_config_find_xdg git_config_find_xdg;
	da_git_config_find_system git_config_find_system;
	da_git_config_find_programdata git_config_find_programdata;
	da_git_config_open_default git_config_open_default;
	da_git_config_new git_config_new;
	da_git_config_add_file_ondisk git_config_add_file_ondisk;
	da_git_config_open_ondisk git_config_open_ondisk;
	da_git_config_open_level git_config_open_level;
	da_git_config_open_global git_config_open_global;
	da_git_config_snapshot git_config_snapshot;
	da_git_config_free git_config_free;
	da_git_config_get_entry git_config_get_entry;
	da_git_config_get_int32 git_config_get_int32;
	da_git_config_get_int64 git_config_get_int64;
	da_git_config_get_bool git_config_get_bool;
	da_git_config_get_path git_config_get_path;
	da_git_config_get_string git_config_get_string;
	da_git_config_get_string_buf git_config_get_string_buf;
	da_git_config_get_multivar_foreach git_config_get_multivar_foreach;
	da_git_config_multivar_iterator_new git_config_multivar_iterator_new;
	da_git_config_next git_config_next;
	da_git_config_iterator_free git_config_iterator_free;
	da_git_config_set_int32 git_config_set_int32;
	da_git_config_set_int64 git_config_set_int64;
	da_git_config_set_bool git_config_set_bool;
	da_git_config_set_string git_config_set_string;
	da_git_config_set_multivar git_config_set_multivar;
	da_git_config_delete_entry git_config_delete_entry;
	da_git_config_delete_multivar git_config_delete_multivar;
	da_git_config_foreach git_config_foreach;
	da_git_config_iterator_new git_config_iterator_new;
	da_git_config_iterator_glob_new git_config_iterator_glob_new;
	da_git_config_foreach_match git_config_foreach_match;
	da_git_config_get_mapped git_config_get_mapped;
	da_git_config_lookup_map_value git_config_lookup_map_value;
	da_git_config_parse_bool git_config_parse_bool;
	da_git_config_parse_int32 git_config_parse_int32;
	da_git_config_parse_int64 git_config_parse_int64;
	da_git_config_parse_path git_config_parse_path;
	da_git_config_backend_foreach_match git_config_backend_foreach_match;
	da_git_config_lock git_config_lock;
	// cred_helpers.h
	da_git_cred_userpass git_cred_userpass;
	da_git_describe_init_options git_describe_init_options;
	da_git_describe_init_format_options git_describe_init_format_options;
	da_git_describe_commit git_describe_commit;
	da_git_describe_workdir git_describe_workdir;
	da_git_describe_format git_describe_format;
	da_git_describe_result_free git_describe_result_free;
	// diff.h
	da_git_diff_init_options git_diff_init_options;
	da_git_diff_find_init_options git_diff_find_init_options;
	da_git_diff_free git_diff_free;
	da_git_diff_tree_to_tree git_diff_tree_to_tree;
	da_git_diff_tree_to_index git_diff_tree_to_index;
	da_git_diff_index_to_workdir git_diff_index_to_workdir;
	da_git_diff_tree_to_workdir git_diff_tree_to_workdir;
	da_git_diff_tree_to_workdir_with_index git_diff_tree_to_workdir_with_index;
	da_git_diff_index_to_index git_diff_index_to_index;
	da_git_diff_merge git_diff_merge;
	da_git_diff_find_similar git_diff_find_similar;
	da_git_diff_num_deltas git_diff_num_deltas;
	da_git_diff_num_deltas_of_type git_diff_num_deltas_of_type;
	da_git_diff_get_delta git_diff_get_delta;
	da_git_diff_is_sorted_icase git_diff_is_sorted_icase;
	da_git_diff_foreach git_diff_foreach;
	da_git_diff_status_char git_diff_status_char;
	da_git_diff_print git_diff_print;
	da_git_diff_to_buf git_diff_to_buf;
	da_git_diff_blobs git_diff_blobs;
	da_git_diff_blob_to_buffer git_diff_blob_to_buffer;
	da_git_diff_buffers git_diff_buffers;
	da_git_diff_from_buffer git_diff_from_buffer;
	da_git_diff_get_stats git_diff_get_stats;
	da_git_diff_stats_files_changed git_diff_stats_files_changed;
	da_git_diff_stats_insertions git_diff_stats_insertions;
	da_git_diff_stats_deletions git_diff_stats_deletions;
	da_git_diff_stats_to_buf git_diff_stats_to_buf;
	da_git_diff_stats_free git_diff_stats_free;
	da_git_diff_format_email git_diff_format_email;
	da_git_diff_commit_as_email git_diff_commit_as_email;
	da_git_diff_format_email_init_options git_diff_format_email_init_options;
	// errors.h
	da_giterr_last giterr_last;
	da_giterr_clear giterr_clear;
	da_giterr_set_str giterr_set_str;
	da_giterr_set_oom giterr_set_oom;
	// filter.h
	da_git_filter_list_load git_filter_list_load;
	da_git_filter_list_contains git_filter_list_contains;
	da_git_filter_list_apply_to_data git_filter_list_apply_to_data;
	da_git_filter_list_apply_to_file git_filter_list_apply_to_file;
	da_git_filter_list_apply_to_blob git_filter_list_apply_to_blob;
	da_git_filter_list_stream_data git_filter_list_stream_data;
	da_git_filter_list_stream_file git_filter_list_stream_file;
	da_git_filter_list_stream_blob git_filter_list_stream_blob;
	da_git_filter_list_free git_filter_list_free;
	// global.h
	da_git_libgit2_init git_libgit2_init;
	da_git_libgit2_shutdown git_libgit2_shutdown;
	// graph.h
	da_git_graph_ahead_behind git_graph_ahead_behind;
	da_git_graph_descendant_of git_graph_descendant_of;
	// ignore.h
	da_git_ignore_add_rule git_ignore_add_rule;
	da_git_ignore_clear_internal_rules git_ignore_clear_internal_rules;
	da_git_ignore_path_is_ignored git_ignore_path_is_ignored;
	// index.h
	da_git_index_open git_index_open;
	da_git_index_new git_index_new;
	da_git_index_free git_index_free;
	da_git_index_owner git_index_owner;
	da_git_index_caps git_index_caps;
	da_git_index_set_caps git_index_set_caps;
	da_git_index_version git_index_version;
	da_git_index_set_version git_index_set_version;
	da_git_index_read git_index_read;
	da_git_index_write git_index_write;
	da_git_index_path git_index_path;
	da_git_index_checksum git_index_checksum;
	da_git_index_read_tree git_index_read_tree;
	da_git_index_write_tree git_index_write_tree;
	da_git_index_write_tree_to git_index_write_tree_to;
	da_git_index_entrycount git_index_entrycount;
	da_git_index_clear git_index_clear;
	da_git_index_get_byindex git_index_get_byindex;
	da_git_index_get_bypath git_index_get_bypath;
	da_git_index_remove git_index_remove;
	da_git_index_remove_directory git_index_remove_directory;
	da_git_index_add git_index_add;
	da_git_index_entry_stage git_index_entry_stage;
	da_git_index_entry_is_conflict git_index_entry_is_conflict;
	da_git_index_add_bypath git_index_add_bypath;
	da_git_index_add_frombuffer git_index_add_frombuffer;
	da_git_index_remove_bypath git_index_remove_bypath;
	da_git_index_add_all git_index_add_all;
	da_git_index_remove_all git_index_remove_all;
	da_git_index_update_all git_index_update_all;
	da_git_index_find git_index_find;
	da_git_index_find_prefix git_index_find_prefix;
	da_git_index_conflict_add git_index_conflict_add;
	da_git_index_conflict_get git_index_conflict_get;
	da_git_index_conflict_remove git_index_conflict_remove;
	da_git_index_conflict_cleanup git_index_conflict_cleanup;
	da_git_index_has_conflicts git_index_has_conflicts;
	da_git_index_conflict_iterator_new git_index_conflict_iterator_new;
	da_git_index_conflict_next git_index_conflict_next;
	da_git_index_conflict_iterator_free git_index_conflict_iterator_free;
	// indexer.h
	da_git_indexer_new git_indexer_new;
	da_git_indexer_append git_indexer_append;
	da_git_indexer_commit git_indexer_commit;
	da_git_indexer_hash git_indexer_hash;
	da_git_indexer_free git_indexer_free;
	// merge.h
	da_git_merge_file_init_input git_merge_file_init_input;
	da_git_merge_file_init_options git_merge_file_init_options;
	da_git_merge_init_options git_merge_init_options;
	da_git_merge_analysis git_merge_analysis;
	da_git_merge_base git_merge_base;
	da_git_merge_bases git_merge_bases;
	da_git_merge_base_many git_merge_base_many;
	da_git_merge_bases_many git_merge_bases_many;
	da_git_merge_base_octopus git_merge_base_octopus;
	da_git_merge_file git_merge_file;
	da_git_merge_file_from_index git_merge_file_from_index;
	da_git_merge_file_result_free git_merge_file_result_free;
	da_git_merge_trees git_merge_trees;
	da_git_merge_commits git_merge_commits;
	da_git_merge git_merge;
	// message.h
	da_git_message_prettify git_message_prettify;
	// notes.h
	da_git_note_iterator_new git_note_iterator_new;
	da_git_note_iterator_free git_note_iterator_free;
	da_git_note_next git_note_next;
	da_git_note_read git_note_read;
	da_git_note_author git_note_author;
	da_git_note_committer git_note_committer;
	da_git_note_message git_note_message;
	da_git_note_id git_note_id;
	da_git_note_create git_note_create;
	da_git_note_remove git_note_remove;
	da_git_note_free git_note_free;
	da_git_note_default_ref git_note_default_ref;
	da_git_note_foreach git_note_foreach;
	// object.h
	da_git_object_lookup git_object_lookup;
	da_git_object_lookup_prefix git_object_lookup_prefix;
	da_git_object_lookup_bypath git_object_lookup_bypath;
	da_git_object_id git_object_id;
	da_git_object_short_id git_object_short_id;
	da_git_object_type git_object_type;
	da_git_object_owner git_object_owner;
	da_git_object_free git_object_free;
	da_git_object_type2string git_object_type2string;
	da_git_object_string2type git_object_string2type;
	da_git_object_typeisloose git_object_typeisloose;
	da_git_object__size git_object__size;
	da_git_object_peel git_object_peel;
	da_git_object_dup git_object_dup;
	// odb.h
	da_git_odb_new git_odb_new;
	da_git_odb_open git_odb_open;
	da_git_odb_add_disk_alternate git_odb_add_disk_alternate;
	da_git_odb_free git_odb_free;
	da_git_odb_read git_odb_read;
	da_git_odb_read_prefix git_odb_read_prefix;
	da_git_odb_read_header git_odb_read_header;
	da_git_odb_exists git_odb_exists;
	da_git_odb_exists_prefix git_odb_exists_prefix;
	da_git_odb_expand_ids git_odb_expand_ids;
	da_git_odb_refresh git_odb_refresh;
	da_git_odb_foreach git_odb_foreach;
	da_git_odb_write git_odb_write;
	da_git_odb_open_wstream git_odb_open_wstream;
	da_git_odb_stream_write git_odb_stream_write;
	da_git_odb_stream_finalize_write git_odb_stream_finalize_write;
	da_git_odb_stream_read git_odb_stream_read;
	da_git_odb_stream_free git_odb_stream_free;
	da_git_odb_open_rstream git_odb_open_rstream;
	da_git_odb_write_pack git_odb_write_pack;
	da_git_odb_hash git_odb_hash;
	da_git_odb_hashfile git_odb_hashfile;
	da_git_odb_object_dup git_odb_object_dup;
	da_git_odb_object_free git_odb_object_free;
	da_git_odb_object_id git_odb_object_id;
	da_git_odb_object_data git_odb_object_data;
	da_git_odb_object_size git_odb_object_size;
	da_git_odb_object_type git_odb_object_type;
	da_git_odb_add_backend git_odb_add_backend;
	da_git_odb_add_alternate git_odb_add_alternate;
	da_git_odb_num_backends git_odb_num_backends;
	da_git_odb_get_backend git_odb_get_backend;
	// odb_backend.h
	da_git_odb_backend_pack git_odb_backend_pack;
	da_git_odb_backend_loose git_odb_backend_loose;
	da_git_odb_backend_one_pack git_odb_backend_one_pack;
	// oid.h
	da_git_oid_fromstr git_oid_fromstr;
	da_git_oid_fromstrp git_oid_fromstrp;
	da_git_oid_fromstrn git_oid_fromstrn;
	da_git_oid_fromraw git_oid_fromraw;
	da_git_oid_fmt git_oid_fmt;
	da_git_oid_nfmt git_oid_nfmt;
	da_git_oid_pathfmt git_oid_pathfmt;
	da_git_oid_tostr_s git_oid_tostr_s;
	da_git_oid_tostr git_oid_tostr;
	da_git_oid_cpy git_oid_cpy;
	da_git_oid_cmp git_oid_cmp;
	da_git_oid_equal git_oid_equal;
	da_git_oid_ncmp git_oid_ncmp;
	da_git_oid_streq git_oid_streq;
	da_git_oid_strcmp git_oid_strcmp;
	da_git_oid_iszero git_oid_iszero;
	da_git_oid_shorten_new git_oid_shorten_new;
	da_git_oid_shorten_add git_oid_shorten_add;
	da_git_oid_shorten_free git_oid_shorten_free;
	// oidarray.h
	da_git_oidarray_free git_oidarray_free;
	// pack.h
	da_git_packbuilder_new git_packbuilder_new;
	da_git_packbuilder_set_threads git_packbuilder_set_threads;
	da_git_packbuilder_insert git_packbuilder_insert;
	da_git_packbuilder_insert_tree git_packbuilder_insert_tree;
	da_git_packbuilder_insert_commit git_packbuilder_insert_commit;
	da_git_packbuilder_insert_walk git_packbuilder_insert_walk;
	da_git_packbuilder_insert_recur git_packbuilder_insert_recur;
	da_git_packbuilder_write_buf git_packbuilder_write_buf;
	da_git_packbuilder_write git_packbuilder_write;
	da_git_packbuilder_hash git_packbuilder_hash;
	da_git_packbuilder_foreach git_packbuilder_foreach;
	da_git_packbuilder_object_count git_packbuilder_object_count;
	da_git_packbuilder_written git_packbuilder_written;
	da_git_packbuilder_set_callbacks git_packbuilder_set_callbacks;
	da_git_packbuilder_free git_packbuilder_free;
	// patch.h
	da_git_patch_from_diff git_patch_from_diff;
	da_git_patch_from_blobs git_patch_from_blobs;
	da_git_patch_from_blob_and_buffer git_patch_from_blob_and_buffer;
	da_git_patch_from_buffers git_patch_from_buffers;
	da_git_patch_free git_patch_free;
	da_git_patch_get_delta git_patch_get_delta;
	da_git_patch_num_hunks git_patch_num_hunks;
	da_git_patch_line_stats git_patch_line_stats;
	da_git_patch_get_hunk git_patch_get_hunk;
	da_git_patch_num_lines_in_hunk git_patch_num_lines_in_hunk;
	da_git_patch_get_line_in_hunk git_patch_get_line_in_hunk;
	da_git_patch_size git_patch_size;
	da_git_patch_print git_patch_print;
	da_git_patch_to_buf git_patch_to_buf;
	// pathspec.h
	da_git_pathspec_new git_pathspec_new;
	da_git_pathspec_free git_pathspec_free;
	da_git_pathspec_matches_path git_pathspec_matches_path;
	da_git_pathspec_match_workdir git_pathspec_match_workdir;
	da_git_pathspec_match_index git_pathspec_match_index;
	da_git_pathspec_match_tree git_pathspec_match_tree;
	da_git_pathspec_match_diff git_pathspec_match_diff;
	da_git_pathspec_match_list_free git_pathspec_match_list_free;
	da_git_pathspec_match_list_entrycount git_pathspec_match_list_entrycount;
	da_git_pathspec_match_list_entry git_pathspec_match_list_entry;
	da_git_pathspec_match_list_diff_entry git_pathspec_match_list_diff_entry;
	da_git_pathspec_match_list_failed_entrycount git_pathspec_match_list_failed_entrycount;
	da_git_pathspec_match_list_failed_entry git_pathspec_match_list_failed_entry;
	// proxy.h
	da_git_proxy_init_options git_proxy_init_options;
	// rebase.h
	da_git_rebase_init_options git_rebase_init_options;
	da_git_rebase_init git_rebase_init;
	da_git_rebase_open git_rebase_open;
	da_git_rebase_operation_entrycount git_rebase_operation_entrycount;
	da_git_rebase_operation_current git_rebase_operation_current;
	da_git_rebase_operation_byindex git_rebase_operation_byindex;
	da_git_rebase_next git_rebase_next;
	da_git_rebase_inmemory_index git_rebase_inmemory_index;
	da_git_rebase_commit git_rebase_commit;
	da_git_rebase_abort git_rebase_abort;
	da_git_rebase_finish git_rebase_finish;
	da_git_rebase_free git_rebase_free;
	// refdb.h
	da_git_refdb_new git_refdb_new;
	da_git_refdb_open git_refdb_open;
	da_git_refdb_compress git_refdb_compress;
	da_git_refdb_free git_refdb_free;
	// reflog.h
	da_git_reflog_read git_reflog_read;
	da_git_reflog_write git_reflog_write;
	da_git_reflog_append git_reflog_append;
	da_git_reflog_rename git_reflog_rename;
	da_git_reflog_delete git_reflog_delete;
	da_git_reflog_entrycount git_reflog_entrycount;
	da_git_reflog_entry_byindex git_reflog_entry_byindex;
	da_git_reflog_drop git_reflog_drop;
	da_git_reflog_entry_id_old git_reflog_entry_id_old;
	da_git_reflog_entry_id_new git_reflog_entry_id_new;
	da_git_reflog_entry_committer git_reflog_entry_committer;
	da_git_reflog_entry_message git_reflog_entry_message;
	da_git_reflog_free git_reflog_free;
	// refs.h
	da_git_reference_lookup git_reference_lookup;
	da_git_reference_name_to_id git_reference_name_to_id;
	da_git_reference_dwim git_reference_dwim;
	da_git_reference_symbolic_create_matching git_reference_symbolic_create_matching;
	da_git_reference_symbolic_create git_reference_symbolic_create;
	da_git_reference_create git_reference_create;
	da_git_reference_create_matching git_reference_create_matching;
	da_git_reference_target git_reference_target;
	da_git_reference_target_peel git_reference_target_peel;
	da_git_reference_symbolic_target git_reference_symbolic_target;
	da_git_reference_type git_reference_type;
	da_git_reference_name git_reference_name;
	da_git_reference_resolve git_reference_resolve;
	da_git_reference_owner git_reference_owner;
	da_git_reference_symbolic_set_target git_reference_symbolic_set_target;
	da_git_reference_set_target git_reference_set_target;
	da_git_reference_rename git_reference_rename;
	da_git_reference_delete git_reference_delete;
	da_git_reference_remove git_reference_remove;
	da_git_reference_list git_reference_list;
	da_git_reference_foreach git_reference_foreach;
	da_git_reference_foreach_name git_reference_foreach_name;
	da_git_reference_dup git_reference_dup;
	da_git_reference_free git_reference_free;
	da_git_reference_cmp git_reference_cmp;
	da_git_reference_iterator_new git_reference_iterator_new;
	da_git_reference_iterator_glob_new git_reference_iterator_glob_new;
	da_git_reference_next git_reference_next;
	da_git_reference_next_name git_reference_next_name;
	da_git_reference_iterator_free git_reference_iterator_free;
	da_git_reference_foreach_glob git_reference_foreach_glob;
	da_git_reference_has_log git_reference_has_log;
	da_git_reference_ensure_log git_reference_ensure_log;
	da_git_reference_is_branch git_reference_is_branch;
	da_git_reference_is_remote git_reference_is_remote;
	da_git_reference_is_tag git_reference_is_tag;
	da_git_reference_is_note git_reference_is_note;
	da_git_reference_normalize_name git_reference_normalize_name;
	da_git_reference_peel git_reference_peel;
	da_git_reference_is_valid_name git_reference_is_valid_name;
	da_git_reference_shorthand git_reference_shorthand;
	// refspec.h
	da_git_refspec_src git_refspec_src;
	da_git_refspec_dst git_refspec_dst;
	da_git_refspec_string git_refspec_string;
	da_git_refspec_force git_refspec_force;
	da_git_refspec_direction git_refspec_direction;
	da_git_refspec_src_matches git_refspec_src_matches;
	da_git_refspec_dst_matches git_refspec_dst_matches;
	da_git_refspec_transform git_refspec_transform;
	da_git_refspec_rtransform git_refspec_rtransform;
	// remote.h
	da_git_remote_create git_remote_create;
	da_git_remote_create_with_fetchspec git_remote_create_with_fetchspec;
	da_git_remote_create_anonymous git_remote_create_anonymous;
	da_git_remote_lookup git_remote_lookup;
	da_git_remote_dup git_remote_dup;
	da_git_remote_owner git_remote_owner;
	da_git_remote_name git_remote_name;
	da_git_remote_url git_remote_url;
	da_git_remote_pushurl git_remote_pushurl;
	da_git_remote_set_url git_remote_set_url;
	da_git_remote_set_pushurl git_remote_set_pushurl;
	da_git_remote_add_fetch git_remote_add_fetch;
	da_git_remote_get_fetch_refspecs git_remote_get_fetch_refspecs;
	da_git_remote_add_push git_remote_add_push;
	da_git_remote_get_push_refspecs git_remote_get_push_refspecs;
	da_git_remote_refspec_count git_remote_refspec_count;
	da_git_remote_get_refspec git_remote_get_refspec;
	da_git_remote_connect git_remote_connect;
	da_git_remote_ls git_remote_ls;
	da_git_remote_connected git_remote_connected;
	da_git_remote_stop git_remote_stop;
	da_git_remote_disconnect git_remote_disconnect;
	da_git_remote_free git_remote_free;
	da_git_remote_list git_remote_list;
	da_git_remote_init_callbacks git_remote_init_callbacks;
	da_git_fetch_init_options git_fetch_init_options;
	da_git_push_init_options git_push_init_options;
	da_git_remote_download git_remote_download;
	da_git_remote_upload git_remote_upload;
	da_git_remote_update_tips git_remote_update_tips;
	da_git_remote_fetch git_remote_fetch;
	da_git_remote_prune git_remote_prune;
	da_git_remote_push git_remote_push;
	da_git_remote_stats git_remote_stats;
	da_git_remote_autotag git_remote_autotag;
	da_git_remote_set_autotag git_remote_set_autotag;
	da_git_remote_prune_refs git_remote_prune_refs;
	da_git_remote_rename git_remote_rename;
	da_git_remote_is_valid_name git_remote_is_valid_name;
	da_git_remote_delete git_remote_delete;
	da_git_remote_default_branch git_remote_default_branch;
	// repository.h
	da_git_repository_open git_repository_open;
	da_git_repository_wrap_odb git_repository_wrap_odb;
	da_git_repository_discover git_repository_discover;
	da_git_repository_open_ext git_repository_open_ext;
	da_git_repository_open_bare git_repository_open_bare;
	da_git_repository_free git_repository_free;
	da_git_repository_init git_repository_init;
	da_git_repository_init_init_options git_repository_init_init_options;
	da_git_repository_init_ext git_repository_init_ext;
	da_git_repository_head git_repository_head;
	da_git_repository_head_detached git_repository_head_detached;
	da_git_repository_head_unborn git_repository_head_unborn;
	da_git_repository_is_empty git_repository_is_empty;
	da_git_repository_path git_repository_path;
	da_git_repository_workdir git_repository_workdir;
	da_git_repository_set_workdir git_repository_set_workdir;
	da_git_repository_is_bare git_repository_is_bare;
	da_git_repository_config git_repository_config;
	da_git_repository_config_snapshot git_repository_config_snapshot;
	da_git_repository_odb git_repository_odb;
	da_git_repository_refdb git_repository_refdb;
	da_git_repository_index git_repository_index;
	da_git_repository_message git_repository_message;
	da_git_repository_message_remove git_repository_message_remove;
	da_git_repository_state_cleanup git_repository_state_cleanup;
	da_git_repository_fetchhead_foreach git_repository_fetchhead_foreach;
	da_git_repository_mergehead_foreach git_repository_mergehead_foreach;
	da_git_repository_hashfile git_repository_hashfile;
	da_git_repository_set_head git_repository_set_head;
	da_git_repository_set_head_detached git_repository_set_head_detached;
	da_git_repository_set_head_detached_from_annotated git_repository_set_head_detached_from_annotated;
	da_git_repository_detach_head git_repository_detach_head;
	da_git_repository_state git_repository_state;
	da_git_repository_set_namespace git_repository_set_namespace;
	da_git_repository_get_namespace git_repository_get_namespace;
	da_git_repository_is_shallow git_repository_is_shallow;
	da_git_repository_ident git_repository_ident;
	da_git_repository_set_ident git_repository_set_ident;
	// reset.h
	da_git_reset git_reset;
	da_git_reset_from_annotated git_reset_from_annotated;
	da_git_reset_default git_reset_default;
	// revert.h
	da_git_revert_init_options git_revert_init_options;
	da_git_revert_commit git_revert_commit;
	da_git_revert git_revert;
	// revparse.h
	da_git_revparse_single git_revparse_single;
	da_git_revparse_ext git_revparse_ext;
	da_git_revparse git_revparse;
	// revwalk.h
	da_git_revwalk_new git_revwalk_new;
	da_git_revwalk_reset git_revwalk_reset;
	da_git_revwalk_push git_revwalk_push;
	da_git_revwalk_push_glob git_revwalk_push_glob;
	da_git_revwalk_push_head git_revwalk_push_head;
	da_git_revwalk_hide git_revwalk_hide;
	da_git_revwalk_hide_glob git_revwalk_hide_glob;
	da_git_revwalk_hide_head git_revwalk_hide_head;
	da_git_revwalk_push_ref git_revwalk_push_ref;
	da_git_revwalk_hide_ref git_revwalk_hide_ref;
	da_git_revwalk_next git_revwalk_next;
	da_git_revwalk_sorting git_revwalk_sorting;
	da_git_revwalk_push_range git_revwalk_push_range;
	da_git_revwalk_simplify_first_parent git_revwalk_simplify_first_parent;
	da_git_revwalk_free git_revwalk_free;
	da_git_revwalk_repository git_revwalk_repository;
	da_git_revwalk_add_hide_cb git_revwalk_add_hide_cb;
	// signature.h
	da_git_signature_new git_signature_new;
	da_git_signature_now git_signature_now;
	da_git_signature_default git_signature_default;
	da_git_signature_from_buffer git_signature_from_buffer;
	da_git_signature_dup git_signature_dup;
	da_git_signature_free git_signature_free;
	// stash.h
	da_git_stash_save git_stash_save;
	da_git_stash_apply_init_options git_stash_apply_init_options;
	da_git_stash_apply git_stash_apply;
	da_git_stash_foreach git_stash_foreach;
	da_git_stash_drop git_stash_drop;
	da_git_stash_pop git_stash_pop;
	// status.h
	da_git_status_init_options git_status_init_options;
	da_git_status_foreach git_status_foreach;
	da_git_status_foreach_ext git_status_foreach_ext;
	da_git_status_file git_status_file;
	da_git_status_list_new git_status_list_new;
	da_git_status_list_entrycount git_status_list_entrycount;
	da_git_status_byindex git_status_byindex;
	da_git_status_list_free git_status_list_free;
	da_git_status_should_ignore git_status_should_ignore;
	// strarray.h
	da_git_strarray_free git_strarray_free;
	da_git_strarray_copy git_strarray_copy;
	// submodule.h
	da_git_submodule_update_init_options git_submodule_update_init_options;
	da_git_submodule_update git_submodule_update;
	da_git_submodule_lookup git_submodule_lookup;
	da_git_submodule_free git_submodule_free;
	da_git_submodule_foreach git_submodule_foreach;
	da_git_submodule_add_setup git_submodule_add_setup;
	da_git_submodule_add_finalize git_submodule_add_finalize;
	da_git_submodule_add_to_index git_submodule_add_to_index;
	da_git_submodule_owner git_submodule_owner;
	da_git_submodule_name git_submodule_name;
	da_git_submodule_path git_submodule_path;
	da_git_submodule_url git_submodule_url;
	da_git_submodule_resolve_url git_submodule_resolve_url;
	da_git_submodule_branch git_submodule_branch;
	da_git_submodule_set_branch git_submodule_set_branch;
	da_git_submodule_set_url git_submodule_set_url;
	da_git_submodule_index_id git_submodule_index_id;
	da_git_submodule_head_id git_submodule_head_id;
	da_git_submodule_wd_id git_submodule_wd_id;
	da_git_submodule_ignore git_submodule_ignore;
	da_git_submodule_set_ignore git_submodule_set_ignore;
	da_git_submodule_update_strategy git_submodule_update_strategy;
	da_git_submodule_set_update git_submodule_set_update;
	da_git_submodule_fetch_recurse_submodules git_submodule_fetch_recurse_submodules;
	da_git_submodule_set_fetch_recurse_submodules git_submodule_set_fetch_recurse_submodules;
	da_git_submodule_init git_submodule_init;
	da_git_submodule_repo_init git_submodule_repo_init;
	da_git_submodule_sync git_submodule_sync;
	da_git_submodule_open git_submodule_open;
	da_git_submodule_reload git_submodule_reload;
	da_git_submodule_status git_submodule_status;
	da_git_submodule_location git_submodule_location;
	// tag.h
	da_git_tag_lookup git_tag_lookup;
	da_git_tag_lookup_prefix git_tag_lookup_prefix;
	da_git_tag_free git_tag_free;
	da_git_tag_id git_tag_id;
	da_git_tag_owner git_tag_owner;
	da_git_tag_target git_tag_target;
	da_git_tag_target_id git_tag_target_id;
	da_git_tag_target_type git_tag_target_type;
	da_git_tag_message git_tag_message;
	da_git_tag_create git_tag_create;
	da_git_tag_annotation_create git_tag_annotation_create;
	da_git_tag_create_frombuffer git_tag_create_frombuffer;
	da_git_tag_create_lightweight git_tag_create_lightweight;
	da_git_tag_delete git_tag_delete;
	da_git_tag_list git_tag_list;
	da_git_tag_list_match git_tag_list_match;
	da_git_tag_foreach git_tag_foreach;
	da_git_tag_peel git_tag_peel;
	da_git_tag_dup git_tag_dup;
	// trace.h
	da_git_trace_set git_trace_set;
	// transaction.h
	da_git_transaction_new git_transaction_new;
	da_git_transaction_lock_ref git_transaction_lock_ref;
	da_git_transaction_set_target git_transaction_set_target;
	da_git_transaction_set_symbolic_target git_transaction_set_symbolic_target;
	da_git_transaction_set_reflog git_transaction_set_reflog;
	da_git_transaction_remove git_transaction_remove;
	da_git_transaction_commit git_transaction_commit;
	da_git_transaction_free git_transaction_free;
	// transport.h
	da_git_cred_has_username git_cred_has_username;
	da_git_cred_userpass_plaintext_new git_cred_userpass_plaintext_new;
	da_git_cred_ssh_key_new git_cred_ssh_key_new;
	da_git_cred_ssh_interactive_new git_cred_ssh_interactive_new;
	da_git_cred_ssh_key_from_agent git_cred_ssh_key_from_agent;
	da_git_cred_ssh_custom_new git_cred_ssh_custom_new;
	da_git_cred_default_new git_cred_default_new;
	da_git_cred_username_new git_cred_username_new;
	da_git_cred_ssh_key_memory_new git_cred_ssh_key_memory_new;
	da_git_cred_free git_cred_free;
	// tree.h
	da_git_tree_lookup git_tree_lookup;
	da_git_tree_lookup_prefix git_tree_lookup_prefix;
	da_git_tree_free git_tree_free;
	da_git_tree_id git_tree_id;
	da_git_tree_owner git_tree_owner;
	da_git_tree_entrycount git_tree_entrycount;
	da_git_tree_entry_byname git_tree_entry_byname;
	da_git_tree_entry_byindex git_tree_entry_byindex;
	da_git_tree_entry_byid git_tree_entry_byid;
	da_git_tree_entry_bypath git_tree_entry_bypath;
	da_git_tree_entry_dup git_tree_entry_dup;
	da_git_tree_entry_free git_tree_entry_free;
	da_git_tree_entry_name git_tree_entry_name;
	da_git_tree_entry_id git_tree_entry_id;
	da_git_tree_entry_type git_tree_entry_type;
	da_git_tree_entry_filemode git_tree_entry_filemode;
	da_git_tree_entry_filemode_raw git_tree_entry_filemode_raw;
	da_git_tree_entry_cmp git_tree_entry_cmp;
	da_git_tree_entry_to_object git_tree_entry_to_object;
	da_git_treebuilder_new git_treebuilder_new;
	da_git_treebuilder_clear git_treebuilder_clear;
	da_git_treebuilder_entrycount git_treebuilder_entrycount;
	da_git_treebuilder_free git_treebuilder_free;
	da_git_treebuilder_get git_treebuilder_get;
	da_git_treebuilder_insert git_treebuilder_insert;
	da_git_treebuilder_remove git_treebuilder_remove;
	da_git_treebuilder_filter git_treebuilder_filter;
	da_git_treebuilder_write git_treebuilder_write;
	da_git_tree_walk git_tree_walk;
	da_git_tree_dup git_tree_dup;
	da_git_tree_create_updated git_tree_create_updated;

	// ADDED IN v0.26.0 RC1, RC2
	// repository.h
	da_git_repository_item_path git_repository_item_path;
	da_git_repository_commondir git_repository_commondir;
	da_git_repository_submodule_cache_all git_repository_submodule_cache_all;
	da_git_repository_submodule_cache_clear git_repository_submodule_cache_clear;

	// branch.h
	da_git_branch_is_checked_out git_branch_is_checked_out;

	// transport.h
	da_git_transport_smart_proxy_options git_transport_smart_proxy_options;

	// worktree.h
	da_git_worktree_list git_worktree_list;
	da_git_worktree_lookup git_worktree_lookup;
	da_git_worktree_open_from_repository git_worktree_open_from_repository;
	da_git_worktree_free git_worktree_free;
	da_git_worktree_validate git_worktree_validate;
	da_git_worktree_add_init_options git_worktree_add_init_options;
	da_git_worktree_add git_worktree_add;
	da_git_worktree_lock git_worktree_lock;
	da_git_worktree_unlock git_worktree_unlock;
	da_it_worktree_is_locked it_worktree_is_locked;
	da_git_worktree_prune_init_options git_worktree_prune_init_options;
	da_git_worktree_is_prunable git_worktree_is_prunable;
	da_git_worktree_prune git_worktree_prune;
}

class DerelictGit2Loader : SharedLibLoader {
	this() {
		super(libNames);
	}

	protected override void loadSymbols() {
		// annotated_commit.h
		bindFunc(cast(void**)&git_annotated_commit_from_ref,"git_annotated_commit_from_ref");
		bindFunc(cast(void**)&git_annotated_commit_from_fetchhead,"git_annotated_commit_from_fetchhead");
		bindFunc(cast(void**)&git_annotated_commit_lookup,"git_annotated_commit_lookup");
		bindFunc(cast(void**)&git_annotated_commit_from_revspec,"git_annotated_commit_from_revspec");
		bindFunc(cast(void**)&git_annotated_commit_id,"git_annotated_commit_id");
		// attr.h
		bindFunc(cast(void**)&git_attr_value,"git_attr_value");
		bindFunc(cast(void**)&git_attr_get,"git_attr_get");
		bindFunc(cast(void**)&git_attr_get_many,"git_attr_get_many");
		bindFunc(cast(void**)&git_attr_foreach,"git_attr_foreach");
		bindFunc(cast(void**)&git_attr_cache_flush,"git_attr_cache_flush");
		bindFunc(cast(void**)&git_attr_add_macro,"git_attr_add_macro");
		// blame.h
		bindFunc(cast(void**)&git_blame_init_options,"git_blame_init_options");
		bindFunc(cast(void**)&git_blame_get_hunk_byindex,"git_blame_get_hunk_byindex");
		bindFunc(cast(void**)&git_blame_get_hunk_byline,"git_blame_get_hunk_byline");
		bindFunc(cast(void**)&git_blame_file,"git_blame_file");
		bindFunc(cast(void**)&git_blame_buffer,"git_blame_buffer");
		bindFunc(cast(void**)&git_blame_free,"git_blame_free");
		// blob.h
		bindFunc(cast(void**)&git_blob_lookup,"git_blob_lookup");
		bindFunc(cast(void**)&git_blob_lookup_prefix,"git_blob_lookup_prefix");
		bindFunc(cast(void**)&git_blob_free,"git_blob_free");
		bindFunc(cast(void**)&git_blob_id,"git_blob_id");
		bindFunc(cast(void**)&git_blob_owner,"git_blob_owner");
		bindFunc(cast(void**)&git_blob_rawcontent,"git_blob_rawcontent");
		bindFunc(cast(void**)&git_blob_rawsize,"git_blob_rawsize");
		bindFunc(cast(void**)&git_blob_filtered_content,"git_blob_filtered_content");
		bindFunc(cast(void**)&git_blob_create_fromworkdir,"git_blob_create_fromworkdir");
		bindFunc(cast(void**)&git_blob_create_fromdisk,"git_blob_create_fromdisk");
		bindFunc(cast(void**)&git_blob_create_fromstream,"git_blob_create_fromstream");
		bindFunc(cast(void**)&git_blob_create_fromstream_commit,"git_blob_create_fromstream_commit");
		bindFunc(cast(void**)&git_blob_create_frombuffer,"git_blob_create_frombuffer");
		bindFunc(cast(void**)&git_blob_is_binary,"git_blob_is_binary");
		bindFunc(cast(void**)&git_blob_dup,"git_blob_dup");
		// branch.h
		bindFunc(cast(void**)&git_branch_create,"git_branch_create");
		bindFunc(cast(void**)&git_branch_create_from_annotated,"git_branch_create_from_annotated");
		bindFunc(cast(void**)&git_branch_delete,"git_branch_delete");
		bindFunc(cast(void**)&git_branch_iterator_new,"git_branch_iterator_new");
		bindFunc(cast(void**)&git_branch_next,"git_branch_next");
		bindFunc(cast(void**)&git_branch_iterator_free,"git_branch_iterator_free");
		bindFunc(cast(void**)&git_branch_move,"git_branch_move");
		bindFunc(cast(void**)&git_branch_lookup,"git_branch_lookup");
		bindFunc(cast(void**)&git_branch_name,"git_branch_name");
		bindFunc(cast(void**)&git_branch_upstream,"git_branch_upstream");
		bindFunc(cast(void**)&git_branch_set_upstream,"git_branch_set_upstream");
		bindFunc(cast(void**)&git_branch_upstream_name,"git_branch_upstream_name");
		bindFunc(cast(void**)&git_branch_is_head,"git_branch_is_head");
		bindFunc(cast(void**)&git_branch_remote_name,"git_branch_remote_name");
		bindFunc(cast(void**)&git_branch_upstream_remote,"git_branch_upstream_remote");
		// buffer.h
		bindFunc(cast(void**)&git_buf_free,"git_buf_free");
		bindFunc(cast(void**)&git_buf_grow,"git_buf_grow");
		bindFunc(cast(void**)&git_buf_set,"git_buf_set");
		bindFunc(cast(void**)&git_buf_is_binary,"git_buf_is_binary");
		bindFunc(cast(void**)&git_buf_contains_nul,"git_buf_contains_nul");
		// checkout.h
		bindFunc(cast(void**)&git_checkout_init_options,"git_checkout_init_options");
		bindFunc(cast(void**)&git_checkout_head,"git_checkout_head");
		bindFunc(cast(void**)&git_checkout_index,"git_checkout_index");
		bindFunc(cast(void**)&git_checkout_tree,"git_checkout_tree");
		// cherrypick.h
		bindFunc(cast(void**)&git_cherrypick_init_options,"git_cherrypick_init_options");
		bindFunc(cast(void**)&git_cherrypick_commit,"git_cherrypick_commit");
		bindFunc(cast(void**)&git_cherrypick,"git_cherrypick");
		// clone.h
		bindFunc(cast(void**)&git_clone_init_options,"git_clone_init_options");
		bindFunc(cast(void**)&git_clone,"git_clone");
		// commit.h
		bindFunc(cast(void**)&git_commit_lookup,"git_commit_lookup");
		bindFunc(cast(void**)&git_commit_lookup_prefix,"git_commit_lookup_prefix");
		bindFunc(cast(void**)&git_commit_free,"git_commit_free");
		bindFunc(cast(void**)&git_commit_id,"git_commit_id");
		bindFunc(cast(void**)&git_commit_owner,"git_commit_owner");
		bindFunc(cast(void**)&git_commit_message_encoding,"git_commit_message_encoding");
		bindFunc(cast(void**)&git_commit_message,"git_commit_message");
		bindFunc(cast(void**)&git_commit_message_raw,"git_commit_message_raw");
		bindFunc(cast(void**)&git_commit_summary,"git_commit_summary");
		bindFunc(cast(void**)&git_commit_body,"git_commit_body");
		bindFunc(cast(void**)&git_commit_time,"git_commit_time");
		bindFunc(cast(void**)&git_commit_time_offset,"git_commit_time_offset");
		bindFunc(cast(void**)&git_commit_committer,"git_commit_committer");
		bindFunc(cast(void**)&git_commit_author,"git_commit_author");
		bindFunc(cast(void**)&git_commit_raw_header,"git_commit_raw_header");
		bindFunc(cast(void**)&git_commit_tree,"git_commit_tree");
		bindFunc(cast(void**)&git_commit_tree_id,"git_commit_tree_id");
		bindFunc(cast(void**)&git_commit_parentcount,"git_commit_parentcount");
		bindFunc(cast(void**)&git_commit_parent,"git_commit_parent");
		bindFunc(cast(void**)&git_commit_parent_id,"git_commit_parent_id");
		bindFunc(cast(void**)&git_commit_nth_gen_ancestor,"git_commit_nth_gen_ancestor");
		bindFunc(cast(void**)&git_commit_header_field,"git_commit_header_field");
		bindFunc(cast(void**)&git_commit_extract_signature,"git_commit_extract_signature");
		bindFunc(cast(void**)&git_commit_create,"git_commit_create");
		bindFunc(cast(void**)&git_commit_create_v,"git_commit_create_v");
		bindFunc(cast(void**)&git_commit_amend,"git_commit_amend");
		bindFunc(cast(void**)&git_commit_create_buffer,"git_commit_create_buffer");
		bindFunc(cast(void**)&git_commit_create_with_signature,"git_commit_create_with_signature");
		bindFunc(cast(void**)&git_commit_dup,"git_commit_dup");
		// common.h
		bindFunc(cast(void**)&git_libgit2_version,"git_libgit2_version");
		bindFunc(cast(void**)&git_libgit2_features,"git_libgit2_features");
		bindFunc(cast(void**)&git_libgit2_opts,"git_libgit2_opts");
		// config.h
		bindFunc(cast(void**)&git_config_entry_free,"git_config_entry_free");
		bindFunc(cast(void**)&git_config_find_global,"git_config_find_global");
		bindFunc(cast(void**)&git_config_find_xdg,"git_config_find_xdg");
		bindFunc(cast(void**)&git_config_find_system,"git_config_find_system");
		bindFunc(cast(void**)&git_config_find_programdata,"git_config_find_programdata");
		bindFunc(cast(void**)&git_config_open_default,"git_config_open_default");
		bindFunc(cast(void**)&git_config_new,"git_config_new");
		bindFunc(cast(void**)&git_config_add_file_ondisk,"git_config_add_file_ondisk");
		bindFunc(cast(void**)&git_config_open_ondisk,"git_config_open_ondisk");
		bindFunc(cast(void**)&git_config_open_level,"git_config_open_level");
		bindFunc(cast(void**)&git_config_open_global,"git_config_open_global");
		bindFunc(cast(void**)&git_config_snapshot,"git_config_snapshot");
		bindFunc(cast(void**)&git_config_free,"git_config_free");
		bindFunc(cast(void**)&git_config_get_entry,"git_config_get_entry");
		bindFunc(cast(void**)&git_config_get_int32,"git_config_get_int32");
		bindFunc(cast(void**)&git_config_get_int64,"git_config_get_int64");
		bindFunc(cast(void**)&git_config_get_bool,"git_config_get_bool");
		bindFunc(cast(void**)&git_config_get_path,"git_config_get_path");
		bindFunc(cast(void**)&git_config_get_string,"git_config_get_string");
		bindFunc(cast(void**)&git_config_get_string_buf,"git_config_get_string_buf");
		bindFunc(cast(void**)&git_config_get_multivar_foreach,"git_config_get_multivar_foreach");
		bindFunc(cast(void**)&git_config_multivar_iterator_new,"git_config_multivar_iterator_new");
		bindFunc(cast(void**)&git_config_next,"git_config_next");
		bindFunc(cast(void**)&git_config_iterator_free,"git_config_iterator_free");
		bindFunc(cast(void**)&git_config_set_int32,"git_config_set_int32");
		bindFunc(cast(void**)&git_config_set_int64,"git_config_set_int64");
		bindFunc(cast(void**)&git_config_set_bool,"git_config_set_bool");
		bindFunc(cast(void**)&git_config_set_string,"git_config_set_string");
		bindFunc(cast(void**)&git_config_set_multivar,"git_config_set_multivar");
		bindFunc(cast(void**)&git_config_delete_entry,"git_config_delete_entry");
		bindFunc(cast(void**)&git_config_delete_multivar,"git_config_delete_multivar");
		bindFunc(cast(void**)&git_config_foreach,"git_config_foreach");
		bindFunc(cast(void**)&git_config_iterator_new,"git_config_iterator_new");
		bindFunc(cast(void**)&git_config_iterator_glob_new,"git_config_iterator_glob_new");
		bindFunc(cast(void**)&git_config_foreach_match,"git_config_foreach_match");
		bindFunc(cast(void**)&git_config_get_mapped,"git_config_get_mapped");
		bindFunc(cast(void**)&git_config_lookup_map_value,"git_config_lookup_map_value");
		bindFunc(cast(void**)&git_config_parse_bool,"git_config_parse_bool");
		bindFunc(cast(void**)&git_config_parse_int32,"git_config_parse_int32");
		bindFunc(cast(void**)&git_config_parse_int64,"git_config_parse_int64");
		bindFunc(cast(void**)&git_config_parse_path,"git_config_parse_path");
		bindFunc(cast(void**)&git_config_backend_foreach_match,"git_config_backend_foreach_match");
		bindFunc(cast(void**)&git_config_lock,"git_config_lock");
		// cred_helpers.h
		bindFunc(cast(void**)&git_cred_userpass,"git_cred_userpass");
		bindFunc(cast(void**)&git_describe_init_options,"git_describe_init_options");
		bindFunc(cast(void**)&git_describe_init_format_options,"git_describe_init_format_options");
		bindFunc(cast(void**)&git_describe_commit,"git_describe_commit");
		bindFunc(cast(void**)&git_describe_workdir,"git_describe_workdir");
		bindFunc(cast(void**)&git_describe_format,"git_describe_format");
		bindFunc(cast(void**)&git_describe_result_free,"git_describe_result_free");
		// diff.h
		bindFunc(cast(void**)&git_diff_init_options,"git_diff_init_options");
		bindFunc(cast(void**)&git_diff_find_init_options,"git_diff_find_init_options");
		bindFunc(cast(void**)&git_diff_free,"git_diff_free");
		bindFunc(cast(void**)&git_diff_tree_to_tree,"git_diff_tree_to_tree");
		bindFunc(cast(void**)&git_diff_tree_to_index,"git_diff_tree_to_index");
		bindFunc(cast(void**)&git_diff_index_to_workdir,"git_diff_index_to_workdir");
		bindFunc(cast(void**)&git_diff_tree_to_workdir,"git_diff_tree_to_workdir");
		bindFunc(cast(void**)&git_diff_tree_to_workdir_with_index,"git_diff_tree_to_workdir_with_index");
		bindFunc(cast(void**)&git_diff_index_to_index,"git_diff_index_to_index");
		bindFunc(cast(void**)&git_diff_merge,"git_diff_merge");
		bindFunc(cast(void**)&git_diff_find_similar,"git_diff_find_similar");
		bindFunc(cast(void**)&git_diff_num_deltas,"git_diff_num_deltas");
		bindFunc(cast(void**)&git_diff_num_deltas_of_type,"git_diff_num_deltas_of_type");
		bindFunc(cast(void**)&git_diff_get_delta,"git_diff_get_delta");
		bindFunc(cast(void**)&git_diff_is_sorted_icase,"git_diff_is_sorted_icase");
		bindFunc(cast(void**)&git_diff_foreach,"git_diff_foreach");
		bindFunc(cast(void**)&git_diff_status_char,"git_diff_status_char");
		bindFunc(cast(void**)&git_diff_print,"git_diff_print");
		bindFunc(cast(void**)&git_diff_to_buf,"git_diff_to_buf");
		bindFunc(cast(void**)&git_diff_blobs,"git_diff_blobs");
		bindFunc(cast(void**)&git_diff_blob_to_buffer,"git_diff_blob_to_buffer");
		bindFunc(cast(void**)&git_diff_buffers,"git_diff_buffers");
		bindFunc(cast(void**)&git_diff_from_buffer,"git_diff_from_buffer");
		bindFunc(cast(void**)&git_diff_get_stats,"git_diff_get_stats");
		bindFunc(cast(void**)&git_diff_stats_files_changed,"git_diff_stats_files_changed");
		bindFunc(cast(void**)&git_diff_stats_insertions,"git_diff_stats_insertions");
		bindFunc(cast(void**)&git_diff_stats_deletions,"git_diff_stats_deletions");
		bindFunc(cast(void**)&git_diff_stats_to_buf,"git_diff_stats_to_buf");
		bindFunc(cast(void**)&git_diff_stats_free,"git_diff_stats_free");
		bindFunc(cast(void**)&git_diff_format_email,"git_diff_format_email");
		bindFunc(cast(void**)&git_diff_commit_as_email,"git_diff_commit_as_email");
		bindFunc(cast(void**)&git_diff_format_email_init_options,"git_diff_format_email_init_options");
		// errors.h
		bindFunc(cast(void**)&giterr_last,"giterr_last");
		bindFunc(cast(void**)&giterr_clear,"giterr_clear");
		bindFunc(cast(void**)&giterr_set_str,"giterr_set_str");
		bindFunc(cast(void**)&giterr_set_oom,"giterr_set_oom");
		// filter.h
		bindFunc(cast(void**)&git_filter_list_load,"git_filter_list_load");
		bindFunc(cast(void**)&git_filter_list_contains,"git_filter_list_contains");
		bindFunc(cast(void**)&git_filter_list_apply_to_data,"git_filter_list_apply_to_data");
		bindFunc(cast(void**)&git_filter_list_apply_to_file,"git_filter_list_apply_to_file");
		bindFunc(cast(void**)&git_filter_list_apply_to_blob,"git_filter_list_apply_to_blob");
		bindFunc(cast(void**)&git_filter_list_stream_data,"git_filter_list_stream_data");
		bindFunc(cast(void**)&git_filter_list_stream_file,"git_filter_list_stream_file");
		bindFunc(cast(void**)&git_filter_list_stream_blob,"git_filter_list_stream_blob");
		bindFunc(cast(void**)&git_filter_list_free,"git_filter_list_free");
		// global.h
		bindFunc(cast(void**)&git_libgit2_init,"git_libgit2_init");
		bindFunc(cast(void**)&git_libgit2_shutdown,"git_libgit2_shutdown");
		// graph.h
		bindFunc(cast(void**)&git_graph_ahead_behind,"git_graph_ahead_behind");
		bindFunc(cast(void**)&git_graph_descendant_of,"git_graph_descendant_of");
		// ignore.h
		bindFunc(cast(void**)&git_ignore_add_rule,"git_ignore_add_rule");
		bindFunc(cast(void**)&git_ignore_clear_internal_rules,"git_ignore_clear_internal_rules");
		bindFunc(cast(void**)&git_ignore_path_is_ignored,"git_ignore_path_is_ignored");
		// index.h
		bindFunc(cast(void**)&git_index_open,"git_index_open");
		bindFunc(cast(void**)&git_index_new,"git_index_new");
		bindFunc(cast(void**)&git_index_free,"git_index_free");
		bindFunc(cast(void**)&git_index_owner,"git_index_owner");
		bindFunc(cast(void**)&git_index_caps,"git_index_caps");
		bindFunc(cast(void**)&git_index_set_caps,"git_index_set_caps");
		bindFunc(cast(void**)&git_index_version,"git_index_version");
		bindFunc(cast(void**)&git_index_set_version,"git_index_set_version");
		bindFunc(cast(void**)&git_index_read,"git_index_read");
		bindFunc(cast(void**)&git_index_write,"git_index_write");
		bindFunc(cast(void**)&git_index_path,"git_index_path");
		bindFunc(cast(void**)&git_index_checksum,"git_index_checksum");
		bindFunc(cast(void**)&git_index_read_tree,"git_index_read_tree");
		bindFunc(cast(void**)&git_index_write_tree,"git_index_write_tree");
		bindFunc(cast(void**)&git_index_write_tree_to,"git_index_write_tree_to");
		bindFunc(cast(void**)&git_index_entrycount,"git_index_entrycount");
		bindFunc(cast(void**)&git_index_clear,"git_index_clear");
		bindFunc(cast(void**)&git_index_get_byindex,"git_index_get_byindex");
		bindFunc(cast(void**)&git_index_get_bypath,"git_index_get_bypath");
		bindFunc(cast(void**)&git_index_remove,"git_index_remove");
		bindFunc(cast(void**)&git_index_remove_directory,"git_index_remove_directory");
		bindFunc(cast(void**)&git_index_add,"git_index_add");
		bindFunc(cast(void**)&git_index_entry_stage,"git_index_entry_stage");
		bindFunc(cast(void**)&git_index_entry_is_conflict,"git_index_entry_is_conflict");
		bindFunc(cast(void**)&git_index_add_bypath,"git_index_add_bypath");
		bindFunc(cast(void**)&git_index_add_frombuffer,"git_index_add_frombuffer");
		bindFunc(cast(void**)&git_index_remove_bypath,"git_index_remove_bypath");
		bindFunc(cast(void**)&git_index_add_all,"git_index_add_all");
		bindFunc(cast(void**)&git_index_remove_all,"git_index_remove_all");
		bindFunc(cast(void**)&git_index_update_all,"git_index_update_all");
		bindFunc(cast(void**)&git_index_find,"git_index_find");
		bindFunc(cast(void**)&git_index_find_prefix,"git_index_find_prefix");
		bindFunc(cast(void**)&git_index_conflict_add,"git_index_conflict_add");
		bindFunc(cast(void**)&git_index_conflict_get,"git_index_conflict_get");
		bindFunc(cast(void**)&git_index_conflict_remove,"git_index_conflict_remove");
		bindFunc(cast(void**)&git_index_conflict_cleanup,"git_index_conflict_cleanup");
		bindFunc(cast(void**)&git_index_has_conflicts,"git_index_has_conflicts");
		bindFunc(cast(void**)&git_index_conflict_iterator_new,"git_index_conflict_iterator_new");
		bindFunc(cast(void**)&git_index_conflict_next,"git_index_conflict_next");
		bindFunc(cast(void**)&git_index_conflict_iterator_free,"git_index_conflict_iterator_free");
		// indexer.h
		bindFunc(cast(void**)&git_indexer_new,"git_indexer_new");
		bindFunc(cast(void**)&git_indexer_append,"git_indexer_append");
		bindFunc(cast(void**)&git_indexer_commit,"git_indexer_commit");
		bindFunc(cast(void**)&git_indexer_hash,"git_indexer_hash");
		bindFunc(cast(void**)&git_indexer_free,"git_indexer_free");
		// merge.h
		bindFunc(cast(void**)&git_merge_file_init_input,"git_merge_file_init_input");
		bindFunc(cast(void**)&git_merge_file_init_options,"git_merge_file_init_options");
		bindFunc(cast(void**)&git_merge_init_options,"git_merge_init_options");
		bindFunc(cast(void**)&git_merge_analysis,"git_merge_analysis");
		bindFunc(cast(void**)&git_merge_base,"git_merge_base");
		bindFunc(cast(void**)&git_merge_bases,"git_merge_bases");
		bindFunc(cast(void**)&git_merge_base_many,"git_merge_base_many");
		bindFunc(cast(void**)&git_merge_bases_many,"git_merge_bases_many");
		bindFunc(cast(void**)&git_merge_base_octopus,"git_merge_base_octopus");
		bindFunc(cast(void**)&git_merge_file,"git_merge_file");
		bindFunc(cast(void**)&git_merge_file_from_index,"git_merge_file_from_index");
		bindFunc(cast(void**)&git_merge_file_result_free,"git_merge_file_result_free");
		bindFunc(cast(void**)&git_merge_trees,"git_merge_trees");
		bindFunc(cast(void**)&git_merge_commits,"git_merge_commits");
		bindFunc(cast(void**)&git_merge,"git_merge");
		// message.h
		bindFunc(cast(void**)&git_message_prettify,"git_message_prettify");
		// notes.h
		bindFunc(cast(void**)&git_note_iterator_new,"git_note_iterator_new");
		bindFunc(cast(void**)&git_note_iterator_free,"git_note_iterator_free");
		bindFunc(cast(void**)&git_note_next,"git_note_next");
		bindFunc(cast(void**)&git_note_read,"git_note_read");
		bindFunc(cast(void**)&git_note_author,"git_note_author");
		bindFunc(cast(void**)&git_note_committer,"git_note_committer");
		bindFunc(cast(void**)&git_note_message,"git_note_message");
		bindFunc(cast(void**)&git_note_id,"git_note_id");
		bindFunc(cast(void**)&git_note_create,"git_note_create");
		bindFunc(cast(void**)&git_note_remove,"git_note_remove");
		bindFunc(cast(void**)&git_note_free,"git_note_free");
		bindFunc(cast(void**)&git_note_default_ref,"git_note_default_ref");
		bindFunc(cast(void**)&git_note_foreach,"git_note_foreach");
		// object.h
		bindFunc(cast(void**)&git_object_lookup,"git_object_lookup");
		bindFunc(cast(void**)&git_object_lookup_prefix,"git_object_lookup_prefix");
		bindFunc(cast(void**)&git_object_lookup_bypath,"git_object_lookup_bypath");
		bindFunc(cast(void**)&git_object_id,"git_object_id");
		bindFunc(cast(void**)&git_object_short_id,"git_object_short_id");
		bindFunc(cast(void**)&git_object_type,"git_object_type");
		bindFunc(cast(void**)&git_object_owner,"git_object_owner");
		bindFunc(cast(void**)&git_object_free,"git_object_free");
		bindFunc(cast(void**)&git_object_type2string,"git_object_type2string");
		bindFunc(cast(void**)&git_object_string2type,"git_object_string2type");
		bindFunc(cast(void**)&git_object_typeisloose,"git_object_typeisloose");
		bindFunc(cast(void**)&git_object__size,"git_object__size");
		bindFunc(cast(void**)&git_object_peel,"git_object_peel");
		bindFunc(cast(void**)&git_object_dup,"git_object_dup");
		// odb.h
		bindFunc(cast(void**)&git_odb_new,"git_odb_new");
		bindFunc(cast(void**)&git_odb_open,"git_odb_open");
		bindFunc(cast(void**)&git_odb_add_disk_alternate,"git_odb_add_disk_alternate");
		bindFunc(cast(void**)&git_odb_free,"git_odb_free");
		bindFunc(cast(void**)&git_odb_read,"git_odb_read");
		bindFunc(cast(void**)&git_odb_read_prefix,"git_odb_read_prefix");
		bindFunc(cast(void**)&git_odb_read_header,"git_odb_read_header");
		bindFunc(cast(void**)&git_odb_exists,"git_odb_exists");
		bindFunc(cast(void**)&git_odb_exists_prefix,"git_odb_exists_prefix");
		bindFunc(cast(void**)&git_odb_expand_ids,"git_odb_expand_ids");
		bindFunc(cast(void**)&git_odb_refresh,"git_odb_refresh");
		bindFunc(cast(void**)&git_odb_foreach,"git_odb_foreach");
		bindFunc(cast(void**)&git_odb_write,"git_odb_write");
		bindFunc(cast(void**)&git_odb_open_wstream,"git_odb_open_wstream");
		bindFunc(cast(void**)&git_odb_stream_write,"git_odb_stream_write");
		bindFunc(cast(void**)&git_odb_stream_finalize_write,"git_odb_stream_finalize_write");
		bindFunc(cast(void**)&git_odb_stream_read,"git_odb_stream_read");
		bindFunc(cast(void**)&git_odb_stream_free,"git_odb_stream_free");
		bindFunc(cast(void**)&git_odb_open_rstream,"git_odb_open_rstream");
		bindFunc(cast(void**)&git_odb_write_pack,"git_odb_write_pack");
		bindFunc(cast(void**)&git_odb_hash,"git_odb_hash");
		bindFunc(cast(void**)&git_odb_hashfile,"git_odb_hashfile");
		bindFunc(cast(void**)&git_odb_object_dup,"git_odb_object_dup");
		bindFunc(cast(void**)&git_odb_object_free,"git_odb_object_free");
		bindFunc(cast(void**)&git_odb_object_id,"git_odb_object_id");
		bindFunc(cast(void**)&git_odb_object_data,"git_odb_object_data");
		bindFunc(cast(void**)&git_odb_object_size,"git_odb_object_size");
		bindFunc(cast(void**)&git_odb_object_type,"git_odb_object_type");
		bindFunc(cast(void**)&git_odb_add_backend,"git_odb_add_backend");
		bindFunc(cast(void**)&git_odb_add_alternate,"git_odb_add_alternate");
		bindFunc(cast(void**)&git_odb_num_backends,"git_odb_num_backends");
		bindFunc(cast(void**)&git_odb_get_backend,"git_odb_get_backend");
		// odb_backend.h
		bindFunc(cast(void**)&git_odb_backend_pack,"git_odb_backend_pack");
		bindFunc(cast(void**)&git_odb_backend_loose,"git_odb_backend_loose");
		bindFunc(cast(void**)&git_odb_backend_one_pack,"git_odb_backend_one_pack");
		// oid.h
		bindFunc(cast(void**)&git_oid_fromstr,"git_oid_fromstr");
		bindFunc(cast(void**)&git_oid_fromstrp,"git_oid_fromstrp");
		bindFunc(cast(void**)&git_oid_fromstrn,"git_oid_fromstrn");
		bindFunc(cast(void**)&git_oid_fromraw,"git_oid_fromraw");
		bindFunc(cast(void**)&git_oid_fmt,"git_oid_fmt");
		bindFunc(cast(void**)&git_oid_nfmt,"git_oid_nfmt");
		bindFunc(cast(void**)&git_oid_pathfmt,"git_oid_pathfmt");
		bindFunc(cast(void**)&git_oid_tostr_s,"git_oid_tostr_s");
		bindFunc(cast(void**)&git_oid_tostr,"git_oid_tostr");
		bindFunc(cast(void**)&git_oid_cpy,"git_oid_cpy");
		bindFunc(cast(void**)&git_oid_cmp,"git_oid_cmp");
		bindFunc(cast(void**)&git_oid_equal,"git_oid_equal");
		bindFunc(cast(void**)&git_oid_ncmp,"git_oid_ncmp");
		bindFunc(cast(void**)&git_oid_streq,"git_oid_streq");
		bindFunc(cast(void**)&git_oid_strcmp,"git_oid_strcmp");
		bindFunc(cast(void**)&git_oid_iszero,"git_oid_iszero");
		bindFunc(cast(void**)&git_oid_shorten_new,"git_oid_shorten_new");
		bindFunc(cast(void**)&git_oid_shorten_add,"git_oid_shorten_add");
		bindFunc(cast(void**)&git_oid_shorten_free,"git_oid_shorten_free");
		// oidarray.h
		bindFunc(cast(void**)&git_oidarray_free,"git_oidarray_free");
		// pack.h
		bindFunc(cast(void**)&git_packbuilder_new,"git_packbuilder_new");
		bindFunc(cast(void**)&git_packbuilder_set_threads,"git_packbuilder_set_threads");
		bindFunc(cast(void**)&git_packbuilder_insert,"git_packbuilder_insert");
		bindFunc(cast(void**)&git_packbuilder_insert_tree,"git_packbuilder_insert_tree");
		bindFunc(cast(void**)&git_packbuilder_insert_commit,"git_packbuilder_insert_commit");
		bindFunc(cast(void**)&git_packbuilder_insert_walk,"git_packbuilder_insert_walk");
		bindFunc(cast(void**)&git_packbuilder_insert_recur,"git_packbuilder_insert_recur");
		bindFunc(cast(void**)&git_packbuilder_write_buf,"git_packbuilder_write_buf");
		bindFunc(cast(void**)&git_packbuilder_write,"git_packbuilder_write");
		bindFunc(cast(void**)&git_packbuilder_hash,"git_packbuilder_hash");
		bindFunc(cast(void**)&git_packbuilder_foreach,"git_packbuilder_foreach");
		bindFunc(cast(void**)&git_packbuilder_object_count,"git_packbuilder_object_count");
		bindFunc(cast(void**)&git_packbuilder_written,"git_packbuilder_written");
		bindFunc(cast(void**)&git_packbuilder_set_callbacks,"git_packbuilder_set_callbacks");
		bindFunc(cast(void**)&git_packbuilder_free,"git_packbuilder_free");
		// patch.h
		bindFunc(cast(void**)&git_patch_from_diff,"git_patch_from_diff");
		bindFunc(cast(void**)&git_patch_from_blobs,"git_patch_from_blobs");
		bindFunc(cast(void**)&git_patch_from_blob_and_buffer,"git_patch_from_blob_and_buffer");
		bindFunc(cast(void**)&git_patch_from_buffers,"git_patch_from_buffers");
		bindFunc(cast(void**)&git_patch_free,"git_patch_free");
		bindFunc(cast(void**)&git_patch_get_delta,"git_patch_get_delta");
		bindFunc(cast(void**)&git_patch_num_hunks,"git_patch_num_hunks");
		bindFunc(cast(void**)&git_patch_line_stats,"git_patch_line_stats");
		bindFunc(cast(void**)&git_patch_get_hunk,"git_patch_get_hunk");
		bindFunc(cast(void**)&git_patch_num_lines_in_hunk,"git_patch_num_lines_in_hunk");
		bindFunc(cast(void**)&git_patch_get_line_in_hunk,"git_patch_get_line_in_hunk");
		bindFunc(cast(void**)&git_patch_size,"git_patch_size");
		bindFunc(cast(void**)&git_patch_print,"git_patch_print");
		bindFunc(cast(void**)&git_patch_to_buf,"git_patch_to_buf");
		// pathspec.h
		bindFunc(cast(void**)&git_pathspec_new,"git_pathspec_new");
		bindFunc(cast(void**)&git_pathspec_free,"git_pathspec_free");
		bindFunc(cast(void**)&git_pathspec_matches_path,"git_pathspec_matches_path");
		bindFunc(cast(void**)&git_pathspec_match_workdir,"git_pathspec_match_workdir");
		bindFunc(cast(void**)&git_pathspec_match_index,"git_pathspec_match_index");
		bindFunc(cast(void**)&git_pathspec_match_tree,"git_pathspec_match_tree");
		bindFunc(cast(void**)&git_pathspec_match_diff,"git_pathspec_match_diff");
		bindFunc(cast(void**)&git_pathspec_match_list_free,"git_pathspec_match_list_free");
		bindFunc(cast(void**)&git_pathspec_match_list_entrycount,"git_pathspec_match_list_entrycount");
		bindFunc(cast(void**)&git_pathspec_match_list_entry,"git_pathspec_match_list_entry");
		bindFunc(cast(void**)&git_pathspec_match_list_diff_entry,"git_pathspec_match_list_diff_entry");
		bindFunc(cast(void**)&git_pathspec_match_list_failed_entrycount,"git_pathspec_match_list_failed_entrycount");
		bindFunc(cast(void**)&git_pathspec_match_list_failed_entry,"git_pathspec_match_list_failed_entry");
		// proxy.h
		bindFunc(cast(void**)&git_proxy_init_options,"git_proxy_init_options");
		// rebase.h
		bindFunc(cast(void**)&git_rebase_init_options,"git_rebase_init_options");
		bindFunc(cast(void**)&git_rebase_init,"git_rebase_init");
		bindFunc(cast(void**)&git_rebase_open,"git_rebase_open");
		bindFunc(cast(void**)&git_rebase_operation_entrycount,"git_rebase_operation_entrycount");
		bindFunc(cast(void**)&git_rebase_operation_current,"git_rebase_operation_current");
		bindFunc(cast(void**)&git_rebase_operation_byindex,"git_rebase_operation_byindex");
		bindFunc(cast(void**)&git_rebase_next,"git_rebase_next");
		bindFunc(cast(void**)&git_rebase_inmemory_index,"git_rebase_inmemory_index");
		bindFunc(cast(void**)&git_rebase_commit,"git_rebase_commit");
		bindFunc(cast(void**)&git_rebase_abort,"git_rebase_abort");
		bindFunc(cast(void**)&git_rebase_finish,"git_rebase_finish");
		bindFunc(cast(void**)&git_rebase_free,"git_rebase_free");
		// refdb.h
		bindFunc(cast(void**)&git_refdb_new,"git_refdb_new");
		bindFunc(cast(void**)&git_refdb_open,"git_refdb_open");
		bindFunc(cast(void**)&git_refdb_compress,"git_refdb_compress");
		bindFunc(cast(void**)&git_refdb_free,"git_refdb_free");
		// reflog.h
		bindFunc(cast(void**)&git_reflog_read,"git_reflog_read");
		bindFunc(cast(void**)&git_reflog_write,"git_reflog_write");
		bindFunc(cast(void**)&git_reflog_append,"git_reflog_append");
		bindFunc(cast(void**)&git_reflog_rename,"git_reflog_rename");
		bindFunc(cast(void**)&git_reflog_delete,"git_reflog_delete");
		bindFunc(cast(void**)&git_reflog_entrycount,"git_reflog_entrycount");
		bindFunc(cast(void**)&git_reflog_entry_byindex,"git_reflog_entry_byindex");
		bindFunc(cast(void**)&git_reflog_drop,"git_reflog_drop");
		bindFunc(cast(void**)&git_reflog_entry_id_old,"git_reflog_entry_id_old");
		bindFunc(cast(void**)&git_reflog_entry_id_new,"git_reflog_entry_id_new");
		bindFunc(cast(void**)&git_reflog_entry_committer,"git_reflog_entry_committer");
		bindFunc(cast(void**)&git_reflog_entry_message,"git_reflog_entry_message");
		bindFunc(cast(void**)&git_reflog_free,"git_reflog_free");
		// refs.h
		bindFunc(cast(void**)&git_reference_lookup,"git_reference_lookup");
		bindFunc(cast(void**)&git_reference_name_to_id,"git_reference_name_to_id");
		bindFunc(cast(void**)&git_reference_dwim,"git_reference_dwim");
		bindFunc(cast(void**)&git_reference_symbolic_create_matching,"git_reference_symbolic_create_matching");
		bindFunc(cast(void**)&git_reference_symbolic_create,"git_reference_symbolic_create");
		bindFunc(cast(void**)&git_reference_create,"git_reference_create");
		bindFunc(cast(void**)&git_reference_create_matching,"git_reference_create_matching");
		bindFunc(cast(void**)&git_reference_target,"git_reference_target");
		bindFunc(cast(void**)&git_reference_target_peel,"git_reference_target_peel");
		bindFunc(cast(void**)&git_reference_symbolic_target,"git_reference_symbolic_target");
		bindFunc(cast(void**)&git_reference_type,"git_reference_type");
		bindFunc(cast(void**)&git_reference_name,"git_reference_name");
		bindFunc(cast(void**)&git_reference_resolve,"git_reference_resolve");
		bindFunc(cast(void**)&git_reference_owner,"git_reference_owner");
		bindFunc(cast(void**)&git_reference_symbolic_set_target,"git_reference_symbolic_set_target");
		bindFunc(cast(void**)&git_reference_set_target,"git_reference_set_target");
		bindFunc(cast(void**)&git_reference_rename,"git_reference_rename");
		bindFunc(cast(void**)&git_reference_delete,"git_reference_delete");
		bindFunc(cast(void**)&git_reference_remove,"git_reference_remove");
		bindFunc(cast(void**)&git_reference_list,"git_reference_list");
		bindFunc(cast(void**)&git_reference_foreach,"git_reference_foreach");
		bindFunc(cast(void**)&git_reference_foreach_name,"git_reference_foreach_name");
		bindFunc(cast(void**)&git_reference_dup,"git_reference_dup");
		bindFunc(cast(void**)&git_reference_free,"git_reference_free");
		bindFunc(cast(void**)&git_reference_cmp,"git_reference_cmp");
		bindFunc(cast(void**)&git_reference_iterator_new,"git_reference_iterator_new");
		bindFunc(cast(void**)&git_reference_iterator_glob_new,"git_reference_iterator_glob_new");
		bindFunc(cast(void**)&git_reference_next,"git_reference_next");
		bindFunc(cast(void**)&git_reference_next_name,"git_reference_next_name");
		bindFunc(cast(void**)&git_reference_iterator_free,"git_reference_iterator_free");
		bindFunc(cast(void**)&git_reference_foreach_glob,"git_reference_foreach_glob");
		bindFunc(cast(void**)&git_reference_has_log,"git_reference_has_log");
		bindFunc(cast(void**)&git_reference_ensure_log,"git_reference_ensure_log");
		bindFunc(cast(void**)&git_reference_is_branch,"git_reference_is_branch");
		bindFunc(cast(void**)&git_reference_is_remote,"git_reference_is_remote");
		bindFunc(cast(void**)&git_reference_is_tag,"git_reference_is_tag");
		bindFunc(cast(void**)&git_reference_is_note,"git_reference_is_note");
		bindFunc(cast(void**)&git_reference_normalize_name,"git_reference_normalize_name");
		bindFunc(cast(void**)&git_reference_peel,"git_reference_peel");
		bindFunc(cast(void**)&git_reference_is_valid_name,"git_reference_is_valid_name");
		bindFunc(cast(void**)&git_reference_shorthand,"git_reference_shorthand");
		// refspec.h
		bindFunc(cast(void**)&git_refspec_src,"git_refspec_src");
		bindFunc(cast(void**)&git_refspec_dst,"git_refspec_dst");
		bindFunc(cast(void**)&git_refspec_string,"git_refspec_string");
		bindFunc(cast(void**)&git_refspec_force,"git_refspec_force");
		bindFunc(cast(void**)&git_refspec_direction,"git_refspec_direction");
		bindFunc(cast(void**)&git_refspec_src_matches,"git_refspec_src_matches");
		bindFunc(cast(void**)&git_refspec_dst_matches,"git_refspec_dst_matches");
		bindFunc(cast(void**)&git_refspec_transform,"git_refspec_transform");
		bindFunc(cast(void**)&git_refspec_rtransform,"git_refspec_rtransform");
		// remote.h
		bindFunc(cast(void**)&git_remote_create,"git_remote_create");
		bindFunc(cast(void**)&git_remote_create_with_fetchspec,"git_remote_create_with_fetchspec");
		bindFunc(cast(void**)&git_remote_create_anonymous,"git_remote_create_anonymous");
		bindFunc(cast(void**)&git_remote_lookup,"git_remote_lookup");
		bindFunc(cast(void**)&git_remote_dup,"git_remote_dup");
		bindFunc(cast(void**)&git_remote_owner,"git_remote_owner");
		bindFunc(cast(void**)&git_remote_name,"git_remote_name");
		bindFunc(cast(void**)&git_remote_url,"git_remote_url");
		bindFunc(cast(void**)&git_remote_pushurl,"git_remote_pushurl");
		bindFunc(cast(void**)&git_remote_set_url,"git_remote_set_url");
		bindFunc(cast(void**)&git_remote_set_pushurl,"git_remote_set_pushurl");
		bindFunc(cast(void**)&git_remote_add_fetch,"git_remote_add_fetch");
		bindFunc(cast(void**)&git_remote_get_fetch_refspecs,"git_remote_get_fetch_refspecs");
		bindFunc(cast(void**)&git_remote_add_push,"git_remote_add_push");
		bindFunc(cast(void**)&git_remote_get_push_refspecs,"git_remote_get_push_refspecs");
		bindFunc(cast(void**)&git_remote_refspec_count,"git_remote_refspec_count");
		bindFunc(cast(void**)&git_remote_get_refspec,"git_remote_get_refspec");
		bindFunc(cast(void**)&git_remote_connect,"git_remote_connect");
		bindFunc(cast(void**)&git_remote_ls,"git_remote_ls");
		bindFunc(cast(void**)&git_remote_connected,"git_remote_connected");
		bindFunc(cast(void**)&git_remote_stop,"git_remote_stop");
		bindFunc(cast(void**)&git_remote_disconnect,"git_remote_disconnect");
		bindFunc(cast(void**)&git_remote_free,"git_remote_free");
		bindFunc(cast(void**)&git_remote_list,"git_remote_list");
		bindFunc(cast(void**)&git_remote_init_callbacks,"git_remote_init_callbacks");
		bindFunc(cast(void**)&git_fetch_init_options,"git_fetch_init_options");
		bindFunc(cast(void**)&git_push_init_options,"git_push_init_options");
		bindFunc(cast(void**)&git_remote_download,"git_remote_download");
		bindFunc(cast(void**)&git_remote_upload,"git_remote_upload");
		bindFunc(cast(void**)&git_remote_update_tips,"git_remote_update_tips");
		bindFunc(cast(void**)&git_remote_fetch,"git_remote_fetch");
		bindFunc(cast(void**)&git_remote_prune,"git_remote_prune");
		bindFunc(cast(void**)&git_remote_push,"git_remote_push");
		bindFunc(cast(void**)&git_remote_stats,"git_remote_stats");
		bindFunc(cast(void**)&git_remote_autotag,"git_remote_autotag");
		bindFunc(cast(void**)&git_remote_set_autotag,"git_remote_set_autotag");
		bindFunc(cast(void**)&git_remote_prune_refs,"git_remote_prune_refs");
		bindFunc(cast(void**)&git_remote_rename,"git_remote_rename");
		bindFunc(cast(void**)&git_remote_is_valid_name,"git_remote_is_valid_name");
		bindFunc(cast(void**)&git_remote_delete,"git_remote_delete");
		bindFunc(cast(void**)&git_remote_default_branch,"git_remote_default_branch");
		// repository.h
		bindFunc(cast(void**)&git_repository_open,"git_repository_open");
		bindFunc(cast(void**)&git_repository_wrap_odb,"git_repository_wrap_odb");
		bindFunc(cast(void**)&git_repository_discover,"git_repository_discover");
		bindFunc(cast(void**)&git_repository_open_ext,"git_repository_open_ext");
		bindFunc(cast(void**)&git_repository_open_bare,"git_repository_open_bare");
		bindFunc(cast(void**)&git_repository_free,"git_repository_free");
		bindFunc(cast(void**)&git_repository_init,"git_repository_init");
		bindFunc(cast(void**)&git_repository_init_init_options,"git_repository_init_init_options");
		bindFunc(cast(void**)&git_repository_init_ext,"git_repository_init_ext");
		bindFunc(cast(void**)&git_repository_head,"git_repository_head");
		bindFunc(cast(void**)&git_repository_head_detached,"git_repository_head_detached");
		bindFunc(cast(void**)&git_repository_head_unborn,"git_repository_head_unborn");
		bindFunc(cast(void**)&git_repository_is_empty,"git_repository_is_empty");
		bindFunc(cast(void**)&git_repository_path,"git_repository_path");
		bindFunc(cast(void**)&git_repository_workdir,"git_repository_workdir");
		bindFunc(cast(void**)&git_repository_set_workdir,"git_repository_set_workdir");
		bindFunc(cast(void**)&git_repository_is_bare,"git_repository_is_bare");
		bindFunc(cast(void**)&git_repository_config,"git_repository_config");
		bindFunc(cast(void**)&git_repository_config_snapshot,"git_repository_config_snapshot");
		bindFunc(cast(void**)&git_repository_odb,"git_repository_odb");
		bindFunc(cast(void**)&git_repository_refdb,"git_repository_refdb");
		bindFunc(cast(void**)&git_repository_index,"git_repository_index");
		bindFunc(cast(void**)&git_repository_message,"git_repository_message");
		bindFunc(cast(void**)&git_repository_message_remove,"git_repository_message_remove");
		bindFunc(cast(void**)&git_repository_state_cleanup,"git_repository_state_cleanup");
		bindFunc(cast(void**)&git_repository_fetchhead_foreach,"git_repository_fetchhead_foreach");
		bindFunc(cast(void**)&git_repository_mergehead_foreach,"git_repository_mergehead_foreach");
		bindFunc(cast(void**)&git_repository_hashfile,"git_repository_hashfile");
		bindFunc(cast(void**)&git_repository_set_head,"git_repository_set_head");
		bindFunc(cast(void**)&git_repository_set_head_detached,"git_repository_set_head_detached");
		bindFunc(cast(void**)&git_repository_set_head_detached_from_annotated,"git_repository_set_head_detached_from_annotated");
		bindFunc(cast(void**)&git_repository_detach_head,"git_repository_detach_head");
		bindFunc(cast(void**)&git_repository_state,"git_repository_state");
		bindFunc(cast(void**)&git_repository_set_namespace,"git_repository_set_namespace");
		bindFunc(cast(void**)&git_repository_get_namespace,"git_repository_get_namespace");
		bindFunc(cast(void**)&git_repository_is_shallow,"git_repository_is_shallow");
		bindFunc(cast(void**)&git_repository_ident,"git_repository_ident");
		bindFunc(cast(void**)&git_repository_set_ident,"git_repository_set_ident");
		// reset.h
		bindFunc(cast(void**)&git_reset,"git_reset");
		bindFunc(cast(void**)&git_reset_from_annotated,"git_reset_from_annotated");
		bindFunc(cast(void**)&git_reset_default,"git_reset_default");
		// revert.h
		bindFunc(cast(void**)&git_revert_init_options,"git_revert_init_options");
		bindFunc(cast(void**)&git_revert_commit,"git_revert_commit");
		bindFunc(cast(void**)&git_revert,"git_revert");
		// revparse.h
		bindFunc(cast(void**)&git_revparse_single,"git_revparse_single");
		bindFunc(cast(void**)&git_revparse_ext,"git_revparse_ext");
		bindFunc(cast(void**)&git_revparse,"git_revparse");
		// revwalk.h
		bindFunc(cast(void**)&git_revwalk_new,"git_revwalk_new");
		bindFunc(cast(void**)&git_revwalk_reset,"git_revwalk_reset");
		bindFunc(cast(void**)&git_revwalk_push,"git_revwalk_push");
		bindFunc(cast(void**)&git_revwalk_push_glob,"git_revwalk_push_glob");
		bindFunc(cast(void**)&git_revwalk_push_head,"git_revwalk_push_head");
		bindFunc(cast(void**)&git_revwalk_hide,"git_revwalk_hide");
		bindFunc(cast(void**)&git_revwalk_hide_glob,"git_revwalk_hide_glob");
		bindFunc(cast(void**)&git_revwalk_hide_head,"git_revwalk_hide_head");
		bindFunc(cast(void**)&git_revwalk_push_ref,"git_revwalk_push_ref");
		bindFunc(cast(void**)&git_revwalk_hide_ref,"git_revwalk_hide_ref");
		bindFunc(cast(void**)&git_revwalk_next,"git_revwalk_next");
		bindFunc(cast(void**)&git_revwalk_sorting,"git_revwalk_sorting");
		bindFunc(cast(void**)&git_revwalk_push_range,"git_revwalk_push_range");
		bindFunc(cast(void**)&git_revwalk_simplify_first_parent,"git_revwalk_simplify_first_parent");
		bindFunc(cast(void**)&git_revwalk_free,"git_revwalk_free");
		bindFunc(cast(void**)&git_revwalk_repository,"git_revwalk_repository");
		bindFunc(cast(void**)&git_revwalk_add_hide_cb,"git_revwalk_add_hide_cb");
		// signature.h
		bindFunc(cast(void**)&git_signature_new,"git_signature_new");
		bindFunc(cast(void**)&git_signature_now,"git_signature_now");
		bindFunc(cast(void**)&git_signature_default,"git_signature_default");
		bindFunc(cast(void**)&git_signature_from_buffer,"git_signature_from_buffer");
		bindFunc(cast(void**)&git_signature_dup,"git_signature_dup");
		bindFunc(cast(void**)&git_signature_free,"git_signature_free");
		// stash.h
		bindFunc(cast(void**)&git_stash_save,"git_stash_save");
		bindFunc(cast(void**)&git_stash_apply_init_options,"git_stash_apply_init_options");
		bindFunc(cast(void**)&git_stash_apply,"git_stash_apply");
		bindFunc(cast(void**)&git_stash_foreach,"git_stash_foreach");
		bindFunc(cast(void**)&git_stash_drop,"git_stash_drop");
		bindFunc(cast(void**)&git_stash_pop,"git_stash_pop");
		// status.h
		bindFunc(cast(void**)&git_status_init_options,"git_status_init_options");
		bindFunc(cast(void**)&git_status_foreach,"git_status_foreach");
		bindFunc(cast(void**)&git_status_foreach_ext,"git_status_foreach_ext");
		bindFunc(cast(void**)&git_status_file,"git_status_file");
		bindFunc(cast(void**)&git_status_list_new,"git_status_list_new");
		bindFunc(cast(void**)&git_status_list_entrycount,"git_status_list_entrycount");
		bindFunc(cast(void**)&git_status_byindex,"git_status_byindex");
		bindFunc(cast(void**)&git_status_list_free,"git_status_list_free");
		bindFunc(cast(void**)&git_status_should_ignore,"git_status_should_ignore");
		// strarray.h
		bindFunc(cast(void**)&git_strarray_free,"git_strarray_free");
		bindFunc(cast(void**)&git_strarray_copy,"git_strarray_copy");
		// submodule.h
		bindFunc(cast(void**)&git_submodule_update_init_options,"git_submodule_update_init_options");
		bindFunc(cast(void**)&git_submodule_update,"git_submodule_update");
		bindFunc(cast(void**)&git_submodule_lookup,"git_submodule_lookup");
		bindFunc(cast(void**)&git_submodule_free,"git_submodule_free");
		bindFunc(cast(void**)&git_submodule_foreach,"git_submodule_foreach");
		bindFunc(cast(void**)&git_submodule_add_setup,"git_submodule_add_setup");
		bindFunc(cast(void**)&git_submodule_add_finalize,"git_submodule_add_finalize");
		bindFunc(cast(void**)&git_submodule_add_to_index,"git_submodule_add_to_index");
		bindFunc(cast(void**)&git_submodule_owner,"git_submodule_owner");
		bindFunc(cast(void**)&git_submodule_name,"git_submodule_name");
		bindFunc(cast(void**)&git_submodule_path,"git_submodule_path");
		bindFunc(cast(void**)&git_submodule_url,"git_submodule_url");
		bindFunc(cast(void**)&git_submodule_resolve_url,"git_submodule_resolve_url");
		bindFunc(cast(void**)&git_submodule_branch,"git_submodule_branch");
		bindFunc(cast(void**)&git_submodule_set_branch,"git_submodule_set_branch");
		bindFunc(cast(void**)&git_submodule_set_url,"git_submodule_set_url");
		bindFunc(cast(void**)&git_submodule_index_id,"git_submodule_index_id");
		bindFunc(cast(void**)&git_submodule_head_id,"git_submodule_head_id");
		bindFunc(cast(void**)&git_submodule_wd_id,"git_submodule_wd_id");
		bindFunc(cast(void**)&git_submodule_ignore,"git_submodule_ignore");
		bindFunc(cast(void**)&git_submodule_set_ignore,"git_submodule_set_ignore");
		bindFunc(cast(void**)&git_submodule_update_strategy,"git_submodule_update_strategy");
		bindFunc(cast(void**)&git_submodule_set_update,"git_submodule_set_update");
		bindFunc(cast(void**)&git_submodule_fetch_recurse_submodules,"git_submodule_fetch_recurse_submodules");
		bindFunc(cast(void**)&git_submodule_set_fetch_recurse_submodules,"git_submodule_set_fetch_recurse_submodules");
		bindFunc(cast(void**)&git_submodule_init,"git_submodule_init");
		bindFunc(cast(void**)&git_submodule_repo_init,"git_submodule_repo_init");
		bindFunc(cast(void**)&git_submodule_sync,"git_submodule_sync");
		bindFunc(cast(void**)&git_submodule_open,"git_submodule_open");
		bindFunc(cast(void**)&git_submodule_reload,"git_submodule_reload");
		bindFunc(cast(void**)&git_submodule_status,"git_submodule_status");
		bindFunc(cast(void**)&git_submodule_location,"git_submodule_location");
		// tag.h
		bindFunc(cast(void**)&git_tag_lookup,"git_tag_lookup");
		bindFunc(cast(void**)&git_tag_lookup_prefix,"git_tag_lookup_prefix");
		bindFunc(cast(void**)&git_tag_free,"git_tag_free");
		bindFunc(cast(void**)&git_tag_id,"git_tag_id");
		bindFunc(cast(void**)&git_tag_owner,"git_tag_owner");
		bindFunc(cast(void**)&git_tag_target,"git_tag_target");
		bindFunc(cast(void**)&git_tag_target_id,"git_tag_target_id");
		bindFunc(cast(void**)&git_tag_target_type,"git_tag_target_type");
		bindFunc(cast(void**)&git_tag_message,"git_tag_message");
		bindFunc(cast(void**)&git_tag_create,"git_tag_create");
		bindFunc(cast(void**)&git_tag_annotation_create,"git_tag_annotation_create");
		bindFunc(cast(void**)&git_tag_create_frombuffer,"git_tag_create_frombuffer");
		bindFunc(cast(void**)&git_tag_create_lightweight,"git_tag_create_lightweight");
		bindFunc(cast(void**)&git_tag_delete,"git_tag_delete");
		bindFunc(cast(void**)&git_tag_list,"git_tag_list");
		bindFunc(cast(void**)&git_tag_list_match,"git_tag_list_match");
		bindFunc(cast(void**)&git_tag_foreach,"git_tag_foreach");
		bindFunc(cast(void**)&git_tag_peel,"git_tag_peel");
		bindFunc(cast(void**)&git_tag_dup,"git_tag_dup");
		// trace.h
		bindFunc(cast(void**)&git_trace_set,"git_trace_set");
		// transaction.h
		bindFunc(cast(void**)&git_transaction_new,"git_transaction_new");
		bindFunc(cast(void**)&git_transaction_lock_ref,"git_transaction_lock_ref");
		bindFunc(cast(void**)&git_transaction_set_target,"git_transaction_set_target");
		bindFunc(cast(void**)&git_transaction_set_symbolic_target,"git_transaction_set_symbolic_target");
		bindFunc(cast(void**)&git_transaction_set_reflog,"git_transaction_set_reflog");
		bindFunc(cast(void**)&git_transaction_remove,"git_transaction_remove");
		bindFunc(cast(void**)&git_transaction_commit,"git_transaction_commit");
		bindFunc(cast(void**)&git_transaction_free,"git_transaction_free");
		// transport.h
		bindFunc(cast(void**)&git_cred_has_username,"git_cred_has_username");
		bindFunc(cast(void**)&git_cred_userpass_plaintext_new,"git_cred_userpass_plaintext_new");
		bindFunc(cast(void**)&git_cred_ssh_key_new,"git_cred_ssh_key_new");
		bindFunc(cast(void**)&git_cred_ssh_interactive_new,"git_cred_ssh_interactive_new");
		bindFunc(cast(void**)&git_cred_ssh_key_from_agent,"git_cred_ssh_key_from_agent");
		bindFunc(cast(void**)&git_cred_ssh_custom_new,"git_cred_ssh_custom_new");
		bindFunc(cast(void**)&git_cred_default_new,"git_cred_default_new");
		bindFunc(cast(void**)&git_cred_username_new,"git_cred_username_new");
		bindFunc(cast(void**)&git_cred_ssh_key_memory_new,"git_cred_ssh_key_memory_new");
		bindFunc(cast(void**)&git_cred_free,"git_cred_free");
		// tree.h
		bindFunc(cast(void**)&git_tree_lookup,"git_tree_lookup");
		bindFunc(cast(void**)&git_tree_lookup_prefix,"git_tree_lookup_prefix");
		bindFunc(cast(void**)&git_tree_free,"git_tree_free");
		bindFunc(cast(void**)&git_tree_id,"git_tree_id");
		bindFunc(cast(void**)&git_tree_owner,"git_tree_owner");
		bindFunc(cast(void**)&git_tree_entrycount,"git_tree_entrycount");
		bindFunc(cast(void**)&git_tree_entry_byname,"git_tree_entry_byname");
		bindFunc(cast(void**)&git_tree_entry_byindex,"git_tree_entry_byindex");
		bindFunc(cast(void**)&git_tree_entry_byid,"git_tree_entry_byid");
		bindFunc(cast(void**)&git_tree_entry_bypath,"git_tree_entry_bypath");
		bindFunc(cast(void**)&git_tree_entry_dup,"git_tree_entry_dup");
		bindFunc(cast(void**)&git_tree_entry_free,"git_tree_entry_free");
		bindFunc(cast(void**)&git_tree_entry_name,"git_tree_entry_name");
		bindFunc(cast(void**)&git_tree_entry_id,"git_tree_entry_id");
		bindFunc(cast(void**)&git_tree_entry_type,"git_tree_entry_type");
		bindFunc(cast(void**)&git_tree_entry_filemode,"git_tree_entry_filemode");
		bindFunc(cast(void**)&git_tree_entry_filemode_raw,"git_tree_entry_filemode_raw");
		bindFunc(cast(void**)&git_tree_entry_cmp,"git_tree_entry_cmp");
		bindFunc(cast(void**)&git_tree_entry_to_object,"git_tree_entry_to_object");
		bindFunc(cast(void**)&git_treebuilder_new,"git_treebuilder_new");
		bindFunc(cast(void**)&git_treebuilder_clear,"git_treebuilder_clear");
		bindFunc(cast(void**)&git_treebuilder_entrycount,"git_treebuilder_entrycount");
		bindFunc(cast(void**)&git_treebuilder_free,"git_treebuilder_free");
		bindFunc(cast(void**)&git_treebuilder_get,"git_treebuilder_get");
		bindFunc(cast(void**)&git_treebuilder_insert,"git_treebuilder_insert");
		bindFunc(cast(void**)&git_treebuilder_remove,"git_treebuilder_remove");
		bindFunc(cast(void**)&git_treebuilder_filter,"git_treebuilder_filter");
		bindFunc(cast(void**)&git_treebuilder_write,"git_treebuilder_write");
		bindFunc(cast(void**)&git_tree_walk,"git_tree_walk");
		bindFunc(cast(void**)&git_tree_dup,"git_tree_dup");
		bindFunc(cast(void**)&git_tree_create_updated,"git_tree_create_updated");

		// ADDED IN v0.26.0 RC1, RC2
		// repository.h
		bindFunc(cast(void**)&git_repository_item_path,"git_repository_item_path");
		bindFunc(cast(void**)&git_repository_commondir,"git_repository_commondir");
		bindFunc(cast(void**)&git_repository_submodule_cache_all,"git_repository_submodule_cache_all");
		bindFunc(cast(void**)&git_repository_submodule_cache_clear,"git_repository_submodule_cache_clear");

		// branch.h
		bindFunc(cast(void**)&git_branch_is_checked_out,"git_branch_is_checked_out");

		// transport.h
		bindFunc(cast(void**)&git_transport_smart_proxy_options,"git_transport_smart_proxy_options");

		// worktree.h
		bindFunc(cast(void**)&git_worktree_list,"git_worktree_list");
		bindFunc(cast(void**)&git_worktree_lookup,"git_worktree_lookup");
		bindFunc(cast(void**)&git_worktree_open_from_repository,"git_worktree_open_from_repository");
		bindFunc(cast(void**)&git_worktree_free,"git_worktree_free");
		bindFunc(cast(void**)&git_worktree_validate,"git_worktree_validate");
		bindFunc(cast(void**)&git_worktree_add_init_options,"git_worktree_add_init_options");
		bindFunc(cast(void**)&git_worktree_add,"git_worktree_add");
		bindFunc(cast(void**)&git_worktree_lock,"git_worktree_lock");
		bindFunc(cast(void**)&git_worktree_unlock,"git_worktree_unlock");
		bindFunc(cast(void**)&it_worktree_is_locked,"it_worktree_is_locked");
		bindFunc(cast(void**)&git_worktree_prune_init_options,"git_worktree_prune_init_options");
		bindFunc(cast(void**)&git_worktree_is_prunable,"git_worktree_is_prunable");
		bindFunc(cast(void**)&git_worktree_prune,"git_worktree_prune");
	}
}

__gshared DerelictGit2Loader DerelictGit2;

shared static this() {
	DerelictGit2 = new DerelictGit2Loader();
}

private static if(Derelict_OS_Windows) {
	enum libNames = "git2.dll";
} else static if(Derelict_OS_Mac) {
	enum libNames = "libgit2.dylib";
} else static if(Derelict_OS_Posix) {
	enum libNames = "libgit2.so,/usr/local/lib/libgit2.so";
} else {
	static assert(0,"Need to implement libgit2 libNames for this operating system.");
}
