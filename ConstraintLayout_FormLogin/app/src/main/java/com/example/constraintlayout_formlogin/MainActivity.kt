package com.example.constraintlayout_formlogin

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main) // hubungkan ke layout

        // ambil komponen dari layout
        val etUsername = findViewById<EditText>(R.id.etUsername)
        val etPassword = findViewById<EditText>(R.id.etPassword)
        val btnLogin = findViewById<Button>(R.id.btnLogin)

        // aksi ketika tombol login ditekan
        btnLogin.setOnClickListener {
            val username = etUsername.text.toString().trim()
            val password = etPassword.text.toString().trim()

            if (username.isEmpty() || password.isEmpty()) {
                Toast.makeText(this, "Isi Username & Password dulu!", Toast.LENGTH_SHORT).show()
            } else if (username == "admin" && password == "1234") {
                Toast.makeText(this, "Login Berhasil ✅", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, "Username atau Password salah ❌", Toast.LENGTH_SHORT).show()
            }
        }
    }
}