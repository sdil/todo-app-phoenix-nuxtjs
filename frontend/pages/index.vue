<template>
  <section class="section">
    <div class="columns is-mobile">
      <h1>Todo App</h1>
      <h2>This Todo app is built using</h2>
      Login here
      <b-button @click="loginWithGoogle()" icon-left="google">
        Sign in with Google
      </b-button>
    </div>
  </section>
</template>

<script>
export default {
  name: "HomePage",
  methods: { loginWithGoogle() {} },
};
</script>
