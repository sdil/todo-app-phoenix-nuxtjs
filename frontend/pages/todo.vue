<template>
  <section class="section">
    <ul v-for="todo in todos" :key="todo.id">
      <li>{{ todo.title }}</li>
    </ul>
  </section>
</template>
<script>
export default {
  data() {
    return {
      todos: [
        {
          id: null,
          title: null,
        },
      ],
    };
  },
  created() {
    // request to API server for list of items
    this.$axios.get("http://localhost:4000/api/todos").then(response => {
      console.log(response.data.data)
      this.todos = response.data.data
    })
  }
};
</script>