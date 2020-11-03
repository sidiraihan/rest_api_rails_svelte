<script>
import {key} from './util.js';
import UsersList from './UsersList.svelte'


  let password = "";
  let username = "";
  let token = "";
  let error;
  let user = { loggedIn: false };
  
  const handleLogin = async () => {
    const response = await fetch("http://localhost:4000/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: JSON.stringify({ username, password }),
	});
	
	const parsed = await response.json();
	
	token = parsed.token;

    if (parsed.error) {
	  error = parsed.error;
	  console.log(parsed);

    } else {
	  window.localStorage.setItem('key', token);
    user.loggedIn = !user.loggedIn;
    error = '';
	  getUsers();
	}
	
  };

  const handleLogout = async () => {
	user.loggedIn = !user.loggedIn;
  //key.set('')
  window.localStorage.clear();
	password = "";
	username = "";
	token = "";
	users_data = [];
  };




</script>






<!--if not logged in-->


{#if !user.loggedIn}
<form on:submit|preventDefault="{handleLogin}" method="post">
  <label>
    Username:
    <input type="text" bind:value="{username}" />
  </label>
  <label>
    Password:
    <input type="password" bind:value="{password}" />
  </label>
  <button type="submit">Login</button>
</form>
{/if}


{#if user.loggedIn}
<button class="btn btn-primary" on:click="{handleLogout}">Logout</button>
<UsersList/>
{/if}

{#if error}
<p>{error}</p>
{/if}