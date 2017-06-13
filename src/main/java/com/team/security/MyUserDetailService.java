package com.team.security;

import com.team.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Created by fantasy on 17-5-28.
 */
public class MyUserDetailService implements UserDetailsService{

	@Autowired
	private UserService userService;

	private Collection<? extends GrantedAuthority> authorities;

	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		com.team.dto.User user = userService.findByUsername(username);
		if(user != null) {
			if(user.getType() == 1) {
				authorities.add(new GrantedAuthorityImpl("ROLE_USER"));
			} else {
				authorities.add(new GrantedAuthorityImpl("ROLE_ADMIN"));
			}
			User user2 = new User(username, user.getPassword(), authorities);
			return user2;
		}
		return null;
	}

}
