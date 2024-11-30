export default {
    namespaced: true,
    state: {
      isAuthenticated: false, 
      user: null,             
    },
    mutations: {
      SET_AUTH(state, status) {
        state.isAuthenticated = status;
      },
      SET_USER(state, user) {
        state.user = user;
      },
    },
    actions: {
      login({ commit }, userData) {
        // Ví dụ: Xử lý đăng nhập
        commit('SET_AUTH', true);
        commit('SET_USER', userData);
      },
      logout({ commit }) {
        commit('SET_AUTH', false);
        commit('SET_USER', null);
      },
    },
    getters: {
      isAuthenticated: (state) => state.isAuthenticated,
      getUser: (state) => state.user,
    },
  };
  