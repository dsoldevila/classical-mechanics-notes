from manim import *
import numpy as np


class SimplePendulum(Scene):
    def construct(self):
        pivot = np.array([0, 2.5, 0])
        L = 2.0

        theta = ValueTracker(0.9)

        rod = Line(
            pivot,
            pivot + np.array([L * np.sin(theta.get_value()), -L * np.cos(theta.get_value()), 0]),
            stroke_width=6,
        )
        bob = Dot(radius=0.12, color=YELLOW)

        def update_rod(m):
            th = theta.get_value()
            end = pivot + np.array([L * np.sin(th), -L * np.cos(th), 0])
            m.put_start_and_end_on(pivot, end)

        def update_bob(m):
            th = theta.get_value()
            end = pivot + np.array([L * np.sin(th), -L * np.cos(th), 0])
            m.move_to(end)

        rod.add_updater(update_rod)
        bob.add_updater(update_bob)

        pivot_dot = Dot(pivot, radius=0.06, color=WHITE)
        self.add(pivot_dot, rod, bob)

        # Swing back and forth (small-angle oscillation approximation)
        self.play(theta.animate.set_value(-0.9), run_time=2, rate_func=linear)
        self.play(theta.animate.set_value(0.9), run_time=2, rate_func=linear)
        self.wait(0.5)
