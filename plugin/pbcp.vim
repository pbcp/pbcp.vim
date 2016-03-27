function! s:pbc(type)
	let binary = 0

	if a:type ==# 'v'
		execute "normal! `<v`>\"py"
		let binary = "b"
	elseif a:type ==# 'V'
		execute "normal! `<V`>\"py"
	elseif a:type ==#  'char'
		execute "normal! `[v`]\"py"
		let binary = "b"
	elseif a:type ==#  'line'
		execute "normal! `[V`]\"py"
	else
	endif

	let tmp = tempname()
	call writefile(split(@p, "\n"), tmp, binary)
	execute system("pbc < " . tmp)
	call delete(tmp)
endfunction

function! s:pbp()
	let @p = system("pbp")
	execute "normal! \"pp"
endfunction

if !exists('g:pbcp_map_keys')
	let g:pbcp_map_keys = 1
endif

if g:pbcp_map_keys
	nnoremap <silent> "py <Esc>:set opfunc=<SID>pbc<cr>g@
	vnoremap <silent> "py :<c-u>call <SID>pbc(visualmode())<cr>

	nnoremap <silent> "pp <Esc>:call <SID>pbp()<cr>
	vnoremap <silent> "pp c<Esc>:<c-u>call <SID>pbp()<cr>
endif
